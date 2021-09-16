#!/bin/bash

SYS_VERSION=$(lsb_release -sc)
if [ "$SYS_VERSION" = "bionic" ]; then
    ROS_VERSION="melodic"
else
    echo -e "\033[1;31m KUBOT not support "$SYS_VERSION"\033[0m"
    exit
fi 

echo "ros:" $ROS_VERSION

if [ "$ROS_VERSION" = "melodic" ]; then
cd 
cd ~/kubot_ros/ros_ws/src/
	git clone https://github.com/KUBOT-Robot/kubot_base_driver.git -b melodic-devel
	git clone https://github.com/KUBOT-Robot/kubot_simulation.git -b melodic-devel
	git clone https://github.com/KUBOT-Robot/kubot_slam_pkg.git -b melodic-devel



else
    exit
fi

# KUBOT_ROS1