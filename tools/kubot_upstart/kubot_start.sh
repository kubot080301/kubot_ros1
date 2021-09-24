#!/bin/bash
# Setting upstart roslaunch

# Setting upstart log
tput setaf 2
echo "Setting upstart log..."
tput sgr0

log_file=/tmp/kubot-upstart.log
echo "$DATE: kubot-start" >>$log_file
kubotenv=/etc/kubotenv
. $kubotenv

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

# Setting KUBOT Initialize to log file
tput setaf 2
echo "Setting KUBOT Initialize to log file..."
tput sgr0

LOCAL_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}')
echo $LOCAL_IP

echo "LOCAL_IP:                $LOCAL_IP" >>$log_file
echo "SYS_VERSION:             $SYS_VERSION" >>$log_file
echo "SYS_KERNEL:             $SYS_VERSION" >>$log_file
echo "ROS_VERSION:             $ROS_VERSION" >>$log_file
echo "KUBOT_MODEL:             $KUBOT_MODEL" >>$log_file
echo "KUBOT_MODEL_TYPE:        $KUBOT_MODEL_TYPE" >>$log_file
echo "KUBOT_BOARD:             $KUBOT_BOARD" >>$log_file
echo "KUBOT_DRIVER_BAUDRATE:   $KUBOT_DRIVER_BAUDRATE" >>$log_file
echo "KUBOT_LIDAR:             $KUBOT_LIDAR" >>$log_file
echo "KUBOT_CAMERA:	           $KUBOT_CAMERA" >>$log_file
echo "KUBOT_DEEP_CAM:          $KUBOT_DEEP_CAM" >>$log_file
echo "ROS_MASTER_URI:          $ROS_MASTER_URI" >>$log_file
echo "ROS_IP:                  $ROS_IP" >>$log_file
echo "ROS_HOSTNAME:            $ROS_HOSTNAME" >>$log_file

# Add launch file
roslaunch kubot_slam_2d gmapping_with_robot.launch

# Finish
tput setaf 2
echo "Finish setting upstart roslaunch!"
tput sgr0

# KUBOT_ROS1
