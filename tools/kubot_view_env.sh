#!/bin/bash
# Check KUBOT environment settings.

# Check System Version
tput setaf 2
echo "Check System Version..."
tput sgr0

SYS_VERSION=$(lsb_release -sc)
SYS_KERNEL=$(arch)

tput setaf 3
echo "System_Version:" $SYS_VERSION
echo "System_Kernel:" $SYS_KERNEL
tput sgr0

# Check ROS1 Version
tput setaf 2
echo "Check ROS1 Version..."
tput sgr0

tput setaf 3
if [ "$SYS_VERSION" = "xenial" ]; then
    ROS_VERSION="kinetic"
    echo "ROS_Version:" $ROS_VERSION
elif [ "$SYS_VERSION" = "bionic" ]; then
    ROS_VERSION="melodic"
    echo "ROS_Version:" $ROS_VERSION
elif [ "$SYS_VERSION" = "focal" ]; then
    ROS_VERSION="noetic"
    echo "ROS_Version:" $ROS_VERSION
else
    tput setaf 1
    echo "KUBOT not support "$SYS_VERSION" system !"
    tput sgr0

    exit
fi
tput sgr0

LOCAL_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}')

# View current settings
tput setaf 5
echo "*****************************************************************"
tput setaf 3
echo "  KUBOT_ENV_INITIALIZED:    "$KUBOT_ENV_INITIALIZED
echo "  LOCAL_IP:                 "$LOCAL_IP
echo "  SYS_VERSION:              "$SYS_VERSION
echo "  SYS_KERNEL:               "$SYS_KERNEL
echo "  ROS_VERSION:              "$ROS_VERSION
echo "  KUBOT_MODEL:              "$KUBOT_MODEL
echo "  KUBOT_MODEL_TYPE:         "$KUBOT_MODEL_TYPE
echo "  KUBOT_BOARD:              "$KUBOT_BOARD
echo "  KUBOT_DRIVER_BOARDRATE:   "$KUBOT_DRIVER_BOARDRATE
echo "  KUBOT_LIDAR:              "$KUBOT_LIDAR
echo "  KUBOT_CAMERA:             "$KUBOT_CAMERA
echo "  KUBOT_DEEP_CAM:           "$KUBOT_DEEP_CAM
echo "  ROS_MASTER_URI:           "$ROS_MASTER_URI
echo "  ROS_IP:                   "$ROS_IP
echo "  ROS_HOSTNAME:             "$ROS_HOSTNAME
tput setaf 5
echo "*****************************************************************"
tput sgr0

# KUBOT_ROS1
