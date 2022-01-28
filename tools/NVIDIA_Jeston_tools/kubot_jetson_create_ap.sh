#! /bin/bash
# This will create wifi ap host of jetson nano.

tput setaf 2
echo "Create WIFI ap host"
tput sgr0

HOST_NAME = "kubot_ap"
PASSWORD = "kubot_ap"
IP = "192.168.5.1"

nmcli con add type wifi ifname wlan0 mode ap con-name kubot_ap ssid ${HOST_NAME}
nmcli con modify kubot_ap 802-11-wireless.band bg
nmcli con modify kubot_ap 802-11-wireless.channel 1
nmcli con modify kubot_ap 802-11-wireless-security.key-mgmt wpa-psk
nmcli con modify kubot_ap 802-11-wireless-security.proto rsn
nmcli con modify kubot_ap 802-11-wireless-security.group ccmp
nmcli con modify kubot_ap 802-11-wireless-security.pairwise ccmp
nmcli con modify kubot_ap 802-11-wireless-security.psk ${PASSWORD}
nmcli con modify kubot_ap ipv4.addr ${IP}/24
nmcli con modify kubot_ap ipv4.method shared
nmcli con up kubot_ap

tput setaf 2
echo "The WIFI ID is : "${HOST_NAME}
echo "The WIFI PASSWORD is : "${PASSWORD}
echo "The WIFI IP is : "${IP}
tput sgr0

# Finish
tput setaf 2
echo "Finish setting WIFI ap!"
tput sgr0

# KUBOT_ROS1
