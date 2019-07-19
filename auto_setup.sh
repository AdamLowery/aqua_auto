cat > /etc/network/interfaces << EOF

# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf

iface default inet static
address 192.168.1.199
netmask 255.255.255.0
gateway 192.168.1.1

EOF

cat > /etc/wpa_supplicant/wpa_supplicant.conf << EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
        ssid="TVRoom"
        psk="LilyJames"
}
EOF

cd ~/
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
sudo cp ./config.json /var/homebridge/
sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
