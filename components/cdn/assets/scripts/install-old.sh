#!/bin/bash
#
# This script was made by @enbytedev for Aerial Laptop projects. 
# Just as the software this helps install, this script is licensed under GNU AGPLv3 to ensure irrevocable permission for anyone's use.
# The name Enbyte and Aerial Laptop as well as the URL and likeless of both Enbyte and Aerial Laptop remain property of Enbyte.
##

set -e

##
# Gather input
##
SELECTION=null
PKG=null
if [ "$1" = '-cb' ]; then
	SELECTION=$2
fi

if [[ "$SELECTION" == null || "$SELECTION" == "" ]]; then
	echo "INSTALLER >>>" Please specify codebase from list with -cb:
	echo ">>> 1 | filing-saucer"
	echo ">>> 2 | anti-airborne"
	echo "INSTALLER >>> Ex, the command for Filing Saucer is:"
	echo ">>> bash <(curl -s https://install.enbyte.dev) -cb 1"
	exit
fi

if [[ $SELECTION -lt 1 || $SELECTION -gt 2 ]]; then
	echo "INSTALLER >>> Invalid selection"
	exit 
fi

case "$SELECTION" in
	1) PKG="filing-saucer";;
	2) PKG="anti-airborne";;
esac

##
# Check for dependencies
##

# Check for NodeJS
if which node > /dev/null
then
	echo "NodeJS is installed."
else
	echo "Please install NodeJS for your operating system to continue."
	exit
fi

# Check for/install PM2 https://pm2.keymetrics.io
if which pm2 > /dev/null
then
	echo "PM2 is installed."
else
	echo "PM2 is NOT installed!"
	echo "Installing PM2 by Keymetrics via npm." 
	echo "You may be asked for your password!"
	sudo npm install pm2 -g
fi

echo "The codebase will be placed in a self-titled folder in the current directory."
echo "Please make sure $PKG/ does not already exist in:"
pwd
while true; do
	read -p "Do you wish to install the requested codebase at this location? (y/n) " yn
	case $yn in
		[Yy]* ) echo "Confirmed"; break;;
		[Nn]* ) echo "Installation aborted!"; exit;;
		* ) echo "Please answer yes or no.";;
	esac
done

mkdir $PKG
cd $PKG

curl -s https://cdn.enbyte.dev/dist/$PKG.tar.gz | tar xvz
npm i

echo "You will now be prompted to configure $PKG"
node main.js -c

while true; do
	read -p "Do you wish to use PM2 to monitor and log $PKG? (y/n) " yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) echo "Successfully downloaded $PKG!"; exit;;
		* ) echo "Please answer yes or no.";;
	esac
done
pm2 start main.js --name "$PKG"
pm2 save

echo "Success! $PKG has been installed and is being monitored by PM2."
echo "PM2 documentation is available at Keymetrics, https://pm2.keymetrics.io/docs/usage/quick-start/"