#!/bin/bash

############ create homebride file ################
cat > /etc/default/homebridge << EOF
# Defaults / Configuration options for homebridge
# The following settings tells homebridge where to find the config.json file and where to persist the data (i.e. pairing and others)
HOMEBRIDGE_OPTS=-U /var/homebridge

# If you uncomment the following line, homebridge will log more
# You can display this via systemd’s journalctl: journalctl -f -u homebridge
# DEBUG=*
EOF
##############################################################
echo "homebridge file complete"



############ create service file #############################
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
##############################################################
echo "service file complete"




#############create homebridge config file ###################
#sudo mkdir /var/homebridge/
cat > /home/pi/.homebridge/config.json << EOF
{
 "bridge": {
  "name": "Lowery Home",
  "username": "CC:23:3D:E3:CE:30",
  "pin": "031-45-153",
  "port": 4083
 },
 "accessories": [
        {
                "accessory": "relay",
                "name": "Hose Pipe",
                "pin" : 7,
                "duration" : 600000
        },
        {
                "accessory": "relay",
                "name": "Sprinklers",
                "pin" : 3,
                "duration" : 600000
        }
                ],
 "platforms": [
       {
      "platform": "rpi-camera",
      "cameras": [{"name": "Pi Camera"}]
    }
  ]
}
EOF
############################################################
echo "config.json complete"


sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
