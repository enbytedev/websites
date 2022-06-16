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
REPO=null
TITLE=null
if [ "$1" = '-cb' ]; then
	SELECTION=$2
fi

if [[ "$SELECTION" == null || "$SELECTION" == "" ]]; then
	echo "INSTALLER >>>" Please specify codebase from list with -cb:
	echo ">>> 1 | filing-saucer"
	echo ">>> 2 | anti-airborne"
	echo "INSTALLER >>> Ex, the command for Filing Saucer is:"
	echo ">>> bash <(curl -s https://al.enbyte.dev/dist/install.sh) -cb 1"
	exit
fi

if [[ $SELECTION -lt 1 || $SELECTION -gt 2 ]]; then
	echo "INSTALLER >>> Invalid selection"
	exit 
fi

case "$SELECTION" in
	1) REPO="https://github.com/Aerial-Laptop/Filing-Saucer.git" ; TITLE="Filing-Saucer" ;;
	2) REPO="https://github.com/Aerial-Laptop/Anti-Airborne.git" ; TITLE="Anti-Airborne" ;;
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
echo "Please make sure $TITLE/ does not already exist in:"
pwd
while true; do
	read -p "Do you wish to install the requested codebase at this location? (y/n) " yn
	case $yn in
		[Yy]* ) echo "Confirmed"; break;;
		[Nn]* ) echo "Installation aborted!"; exit;;
		* ) echo "Please answer yes or no.";;
	esac
done
git clone $REPO
cd $TITLE
npm i

echo "You will now be prompted to configure $TITLE"
node main.js -c

pm2 start main.js --name "$TITLE"
pm2 save

echo "Success! $TITLE has been installed and is being monitored by PM2."
echo "PM2 documentation is available at Keymetrics, https://pm2.keymetrics.io/docs/usage/quick-start/"