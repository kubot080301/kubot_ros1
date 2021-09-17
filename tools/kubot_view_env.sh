#!/bin/bash

SYS_VERSION=$(lsb_release -sc)
SYS_KERNEL=$(arch)

tput setaf 3
if [ "$SYS_VERSION" = "xenial" ]; then
    ROS_VERSION="kinetic"
elif [ "$SYS_VERSION" = "bionic" ]; then
    ROS_VERSION="melodic"
elif [ "$SYS_VERSION" = "focal" ]; then
    ROS_VERSION="noetic"
else
    echo -e "\033[1;31m KUBOT not support "$SYS_VERSION"\033[0m"
    exit
fi
tput sgr0

LOCAL_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}')

# View current settings
tput setaf 5
echo "*****************************************************************"
tput setaf 3
echo "  KUBOT_ENV_INITIALIZED:    "$KUBOT_ENV_INITIALIZED
echo "  SYS_VERSION:              "$SYS_VERSION
echo "  ROS_VERSION:              "$ROS_VERSION
echo "  LOCAL_IP:                 "$LOCAL_IP
echo "  ROS_MASTER_URI:           "$ROS_MASTER_URI
echo "  ROS_IP:                   "$ROS_IP
echo "  ROS_HOSTNAME:             "$ROS_HOSTNAME
echo "  KUBOT_MODEL:              "$KUBOT_MODEL
echo "  KUBOT_MODEL_TYPE:         "$KUBOT_MODEL_TYPE
echo "  KUBOT_LIDAR:              "$KUBOT_LIDAR
echo "  KUBOT_BOARD:              "$KUBOT_BOARD
echo "  KUBOT_3DSENSOR:           "$KUBOT_3DSENSOR
tput setaf 5
echo "*****************************************************************"
tput sgr0
