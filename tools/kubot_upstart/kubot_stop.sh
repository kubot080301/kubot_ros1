#!/bin/bash

log_file=/tmp/kubot-upstart.log
echo "$DATE: kubot-stop" >> $log_file
kubotenv=/etc/kubotenv
. $kubotenv

SYS_VERSION=$(lsb_release -sc)
if [ "$SYS_VERSION" = "bionic" ]; then
    ROS_VERSION="melodic"
else
    echo -e "\033[1;31m KUBOT not support "$SYS_VERSION"\033[0m"
    exit
fi 

LOCAL_IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}'`
echo $LOCAL_IP

echo "KUBOT_MODEL:             $KUBOT_MODEL" >> $log_file
echo "KUBOT_MODEL_TYPE:        $KUBOT_MODEL_TYPE" >> $log_file
echo "KUBOT_BOARD:             $KUBOT_BOARD" >> $log_file
echo "KUBOT_DRIVER_BAUDRATE:   $KUBOT_DRIVER_BAUDRATE" >> $log_file
echo "KUBOT_LIDAR:             $KUBOT_LIDAR" >> $log_file
echo "KUBOT_CAMERA:	           $KUBOT_CAMERA" >> $log_file
echo "KUBOT_DEEP_CAM:          $KUBOT_DEEP_CAM" >> $log_file
echo "SYS_VERSION:             $SYS_VERSION" >> $log_file
echo "ROS_VERSION:             $ROS_VERSION" >> $log_file
echo "ROS_HOSTNAME:            $ROS_HOSTNAME" >> $log_file
echo "LOCAL_IP:                $LOCAL_IP" >> $log_file
echo "ROS_MASTER_URI:          $ROS_MASTER_URI" >> $log_file
echo "ROS_IP:                  $ROS_IP" >> $log_file

for i in $( rosnode list ); do
    rosnode kill $i;
done

killall roslaunch

# KUBOT_ROS1