#!/usr/bin/env bash
#   Enbyte project installer
#   Code licensed under MIT
##

set -e

# Check for NodeJS
if !(which node > /dev/null)
then
	echo "Please install NodeJS for your operating system to continue."
	exit
fi
# Check for npm
if !(which npm > /dev/null)
then
	echo "Please install npm for your operating system to continue."
	exit
fi
# Check for git
if !(which git > /dev/null)
then
	echo "Please install git for your operating system to continue."
	exit
fi

# Check for/install PM2 https://pm2.keymetrics.io
# Only required when specified
PM2=false
checkPm2() {
    if which pm2 > /dev/null
    then
        PM2=true
    else
        echo "PM2 is NOT installed!"
        echo "Installing PM2 by Keymetrics via npm." 
        echo "You may be asked for your password!"
        sudo npm install pm2 -g
    fi
}

anti_airborne() {
    echo -ne "
Anti Airborne
========================
  > 1 | Clone Anti Airborne
  > 2 | Install Anti Airborne via PM2
  > 3 | Cancel

>  "
    read -r ans
    case $ans in
    1)
        c_anti_airborne
        ;;
    2)
        i_anti_airborne
        ;;
    3)
        menu
        ;;
    *)
        echo "INVALID SELECTION"
        menu
        ;;
    esac
}

c_anti_airborne() {
    echo "Cloning Filing Saucer..."
    git clone https://github.com/enbytedev/Anti-Airborne
    echo "Done."
    exit
}

i_anti_airborne() {
    echo "Installing Filing Saucer..."
    checkPm2
    if [ "$PM2" = true ]; then
        git clone https://github.com/enbytedev/Anti-Airborne
        cd Anti-Airborne || exit
        npm install
        pm2 start main.js --name "Anti-Airborne"
        echo "Done."
        exit
    else
        echo "Failed since PM2 is NOT installed."
        exit
    fi
}

filing_saucer() {
    echo -ne "
Filing Saucer
========================
  > 1 | Clone Filing Saucer
  > 2 | Install Filing Saucer via PM2
  > 3 | Cancel

>  "
    read -r ans
    case $ans in
    1)
        c_filing_saucer
        ;;
    2)
        i_filing_saucer
        ;;
    3)
        menu
        ;;
    *)
        echo "INVALID SELECTION"
        menu
        ;;
    esac
}

c_filing_saucer() {
    echo "Cloning Filing Saucer..."
    git clone https://github.com/enbytedev/Filing-Saucer
    echo "Done."
    exit
}

i_filing_saucer() {
    echo "Installing Filing Saucer..."
    checkPm2
    if [ "$PM2" = true ]; then
        git clone https://github.com/enbytedev/Filing-Saucer
        cd Filing-Saucer || exit
        npm install
        pm2 start main.js --name "Filing-Saucer"
        echo "Done."
        exit
    else
        echo "Failed since PM2 is NOT installed."
        exit
    fi
}

menu() {
    echo -ne "
Enbyte Project Installer
========================
  > 1 | Filing Saucer
  > 2 | Anti Airborne
  > 3 | Exit

>  "
    read -r ans
    case $ans in
    1)
        filing_saucer
        ;;
    2)
        anti_airborne
        ;;
    3)
        echo "Exited."
        exit 0
        ;;
    *)
        echo "INVALID SELECTION"
        menu
        ;;
    esac
}

menu