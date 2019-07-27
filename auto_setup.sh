#!/bin/bash

sudo systemctl enable ssh
sudo systemctl start ssh
yes Y | sudo apt-get update
yes Y | sudo apt-get upgrade
yes Y | curl -sSL goo.gl/Ksdhph | bash
yes Y | npm i homebridge-gpio-relay
yes Y | sudo apt-get install nodejs npm
yes Y | npm i pi-gpio
make sure package.json is created
sudo npm install -g homebridge-gpio-relay
git clone git://github.com/jamesblanksby/quick2wire-gpio-admin.git
cd quick2wire-gpio-admin
make
sudo make install
sudo su pi
sudo adduser $USER gpio

#create files for service creation

cat > /etc/default/homebridge << EOF
# Defaults / Configuration options for homebridge
# The following settings tells homebridge where to find the config.json file and where to persist the data (i.e. pairing and others)
HOMEBRIDGE_OPTS=-U /var/homebridge

# If you uncomment the following line, homebridge will log more
# You can display this via systemd’s journalctl: journalctl -f -u homebridge
# DEBUG=*

EOF

cat > /etc/systemd/system/homebridge.service << EOF
[Unit]
Description=Node.js HomeKit Server
After=syslog.target network-online.target

[Service]
Type=simple
User=pi
EnvironmentFile=/etc/default/homebridge
ExecStart=/usr/local/bin/homebridge $HOMEBRIDGE_OPTS
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target

EOF

sudo mkdir /var/homebridge
sudo cp ./config.json sudo cp ./config.json /home/pi/.homebridge/
sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
chmod +x ~/aqua_auto/all_on_15mins.py
