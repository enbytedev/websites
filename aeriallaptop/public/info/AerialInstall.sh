#!/bin/bash
set -e

CODEBASE=null

if [ "$1" = '--codebase' ]; then
	echo "> Downloading Aerial Laptop codebase - $2"
	CODEBASE=$2
fi

git clone https://github.com/Aerial-Laptop/$2.git
cd $2
npm i

npm install pm2 -g

mv .env.example .env
nano .env

pm2 start main.js --name $2
pm2 save

echo "To restart $2, run `pm2 restart $2`"
echo "Successfully installed Aerial Laptop's codebase: $2. Enjoy!"