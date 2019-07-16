sudo bash -c "cat <<EOF >> /etc/network/interfaces1

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
"
sudo systemctl enable ssh
sudo systemctl start ssh
