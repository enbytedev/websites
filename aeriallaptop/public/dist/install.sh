#!/bin/bash
#
# This script was made by @enbytedev for Aerial Laptop projects. 
# Just as the software this helps install, any unique and/or significant part of this script is licensed under GNU AGPLv3 to ensure irrevocable permission for anyone's use.
# The name Enbyte and Aerial Laptop as well as the URL and likeless of both Enbyte and Aerial Laptop remain property of Enbyte.
##

set -e

case "$OSTYPE" in
	darwin*)  OS="macos" ;; # Mac 
	linux*)   OS="linux" ;; # Linux
	msys*)    echo "INSTALLER >>> Windows installation is not supported!"; exit;; # Windows
	cygwin*)  echo "INSTALLER >>> Windows installation is not supported!"; exit;; # Windows
	*)        echo "INSTALLER >>> Unknown OS. Not supported!"; exit;; # Unknown
esac

SELECTION=null
CODEBASE=null
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
	1) CODEBASE="filing-saucer" ;;
	2) CODEBASE="anti-airborne" ;;
esac

echo "INSTALLER >>> Downloading binary file for $CODEBASE on $OS"
if [ ! -d "./$CODEBASE" ]; then
mkdir $CODEBASE
fi
cd $CODEBASE
curl --progress-bar -o "$CODEBASE-$OS" https://al.enbyte.dev/dist/$CODEBASE-$OS 

chmod a+x "./$CODEBASE-$OS"
echo "INSTALLER >>> Please set up $CODEBASE with the --configure argument."
echo ">>> $CODEBASE has been downloaded for $OS! You may run it via ./$CODEBASE-$OS from within the ./$CODEBASE/ directory"
exit