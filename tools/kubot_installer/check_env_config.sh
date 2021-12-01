#!/bin/bash

# This is KUBOT Robot check environment config settings script.

SCRIPT_DIR_O=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
SCRIPT_NAME_O=$(basename ${BASH_SOURCE[0]})
source $SCRIPT_DIR_O/bash_utils.sh

# Check ARCH
export SYS_KERNEL=$(arch)
echo_yellow "[${SCRIPT_NAME_O}] ARCH: ${SYS_KERNEL}"

unset SCRIPT_DIR_O

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