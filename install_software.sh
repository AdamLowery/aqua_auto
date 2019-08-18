#!/bin/bash

yes Y | sudo apt-get update
yes Y | sudo apt-get upgrade
yes Y | curl -sSL goo.gl/Ksdhph | bash
yes Y | npm i homebridge-gpio-relay
yes Y | sudo apt-get install nodejs npm
yes Y | npm i pi-gpio
#make sure package.json is created
sudo npm install -g homebridge-gpio-relay
git clone git://github.com/jamesblanksby/quick2wire-gpio-admin.git
cd quick2wire-gpio-admin
make
sudo make install
sudo su pi
sudo adduser $USER gpio
sudo apt install ffmpeg
npm install -g homebridge-camera-rpi
