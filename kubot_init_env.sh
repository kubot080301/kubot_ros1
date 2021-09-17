#!/bin/bash
# Initialize KUBOT Robots setting and establish the environment required by kubot_ros1.
# For more explanation, please see here:
# https://

sudo ln -sf ~/kubot_ros1/kubot_init_env.sh /usr/bin/kubot_init_env
sudo ln -sf ~/kubot_ros1/tools/kubot_view_env.sh /usr/bin/kubot_view_env

# Build udev rulse
if ! [ $KUBOT_ROS1_ENV_INITIALIZED ]; then
    tput setaf 2
    echo "Build udev rulse..."
    tput sgr0

    cd ~/kubot_ros1/
    echo " " >>~/.bashrc
    echo "# Load KUBOT_ROS1's environment variables." >>~/.bashrc
    echo "export KUBOT_ROS1_ENV_INITIALIZED=1" >>~/.bashrc
    echo "source ~/.kubotros1rc" >>~/.bashrc

    # Copy rules to /etc/udev
    sudo cp rules/71-kubot-driver-board.rules /etc/udev/rules.d/
    sudo cp rules/72-kubot-lidar.rules /etc/udev/rules.d/
    sudo cp rules/73-kubot-camera.rules /etc/udev/rules.d/

    # Restarting udev
    sudo udevadm control --reload-rules
    sudo udevadm trigger
fi

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
    echo -e "\033[1;31m KUBOT not support "$SYS_VERSION"\033[0m"
    exit
fi
tput sgr0

# Content Source ROS1
tput setaf 2
echo "Content Source ROS1..."
tput sgr0

content="#source ros
if [ ! -f /opt/ros/${ROS_VERSION}/setup.bash ]; then 
    echo \"please run cd ~/kubot_ros1/tools/kubot_installer/ && ./kubot_install_ros.sh to install ros sdk\"
else
    source /opt/ros/${ROS_VERSION}/setup.bash
fi"
echo "${content}" >~/.kubotros1rc

# Check Network IP
tput setaf 2
echo "Check Network IP..."
tput sgr0

LOCAL_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}')
echo "LOCAL_IP=\`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | awk -F"/" '{print \$1}'\`" >>~/.kubotros1rc

if [ ! ${LOCAL_IP} ]; then
    echo -e "\033[1;31m Please check network\033[0m"
    exit
fi

# Specify KUBOT robot model
tput setaf 2
echo "Please specify kubot robot model:"
tput setaf 3
echo "
    1 : Kubot2 (Cagebot)
    2 : Neuronbot2 (Adlink)
    3 : WAGV (ShanYangYe)
    4 : Aider (ShanYangYe)

    s1 : Sample Two-Wheel-Differential-Model
    s2 : Sample Four-Whell-Differential-Model
    s3 : Sample There-Omni-Wheel-Omnidirectional-Model
    s4 : Sample Four-Omni-Wheel-Omnidirectional-Model
    s5 : Sample Four-Mecanum-Omnidirectional-Model
    s6 : Sample Four-Ackermann-non-Holonomic-Model
    "
tput sgr0

read -p "" KUBOT_MODEL_INPUT

if [ "$KUBOT_MODEL_INPUT" = "1" ]; then
    KUBOT_MODEL='kubot2'
    KUBOT_MODEL_TYPE='diff-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "2" ]; then
    KUBOT_MODEL='neuronbot2'
    KUBOT_MODEL_TYPE='diff-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "3" ]; then
    KUBOT_MODEL='wagv'
    KUBOT_MODEL_TYPE='diff-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "4" ]; then
    KUBOT_MODEL='aider'
    KUBOT_MODEL_TYPE='diff-corrected'

elif [ "$KUBOT_MODEL_INPUT" = "s1" ]; then
    KUBOT_MODEL='s1_2wd_diff'
    KUBOT_MODEL_TYPE='diff-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "s2" ]; then
    KUBOT_MODEL='s2_4wd_diff'
    KUBOT_MODEL_TYPE='diff-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "s3" ]; then
    KUBOT_MODEL='s3_3wd_omni'
    KUBOT_MODEL_TYPE='omni-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "s4" ]; then
    KUBOT_MODEL='s4_4wd_omni'
    KUBOT_MODEL_TYPE='omni-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "s5" ]; then
    KUBOT_MODEL='s5_4wd_mecanum'
    KUBOT_MODEL_TYPE='omni-corrected'
elif [ "$KUBOT_MODEL_INPUT" = "s6" ]; then
    KUBOT_MODEL='s6_4wd_arkermann'
    KUBOT_MODEL_TYPE='diff-corrected'
else
    KUBOT_MODEL=$KUBOT_MODEL_INPUT
    KUBOT_MODEL_TYPE='diff-corrected'
fi

# Specify KUBOT driver board
tput setaf 2
echo "Please specify kubot driver board type:"
tput setaf 3
echo "
    1 : Arduino(mega2560)
    2 : Teensy(teensy40)
    3 : STM32(f103rc) 
    "
tput sgr0

read -p "" KUBOT_DIRVER_BOARD_INPUT

if [ "$KUBOT_DIRVER_BOARD_INPUT" = "1" ]; then
    KUBOT_BOARD='arduino-mega'
    KUBOT_DRIVER_BAUDRATE=115200
elif [ "$KUBOT_DIRVER_BOARD_INPUT" = "2" ]; then
    KUBOT_BOARD='teensy-40'
    KUBOT_DRIVER_BAUDRATE=500000
elif [ "$KUBOT_DIRVER_BOARD_INPUT" = "3" ]; then
    KUBOT_BOARD='stm32f103'
    KUBOT_DRIVER_BAUDRATE=115200
else
    KUBOT_BOARD=$KUBOT_DIRVER_BOARD_INPUT
    KUBOT_DRIVER_BAUDRATE=115200
fi

# Specify  KUBOT lidar
tput setaf 2
echo "Please specify  kubot lidar:"
tput setaf 3
echo "
    0 : not config
    1 : rplidar(a1)
    2 : rplidar(a2)
    3 : rplidar(a3)
    4 : rplidar(s1) 
    5 : xtion
    6 : kinect(V2)
    7 : astra
    8 : realsense(d435i)
    9 : sick(tim551)
    10 : hokuyo(ust-10lx)

    s1 : two_rplidar(a2)
    "
tput sgr0

read -p "" KUBOT_LIDAR_INPUT

if [ "$KUBOT_LIDAR_INPUT" = "0" ]; then
    KUBOT_LIDAR='non-lidar'
elif [ "$KUBOT_LIDAR_INPUT" = "1" ]; then
    KUBOT_LIDAR='rplidar-a1'
elif [ "$KUBOT_LIDAR_INPUT" = "2" ]; then
    KUBOT_LIDAR='rplidar-a2'
elif [ "$KUBOT_LIDAR_INPUT" = "3" ]; then
    KUBOT_LIDAR='rplidar-a3'
elif [ "$KUBOT_LIDAR_INPUT" = "4" ]; then
    KUBOT_LIDAR='rplidar-s1'
elif [ "$KUBOT_LIDAR_INPUT" = "5" ]; then
    KUBOT_LIDAR='xtion'
elif [ "$KUBOT_LIDAR_INPUT" = "6" ]; then
    KUBOT_LIDAR='kinectV2'
elif [ "$KUBOT_LIDAR_INPUT" = "7" ]; then
    KUBOT_LIDAR='astra'
elif [ "$KUBOT_LIDAR_INPUT" = "8" ]; then
    KUBOT_LIDAR='d435i'
elif [ "$KUBOT_LIDAR_INPUT" = "9" ]; then
    KUBOT_LIDAR='sick-tim551'
elif [ "$KUBOT_LIDAR_INPUT" = "10" ]; then
    KUBOT_LIDAR='hokuyo-10ls'

elif [ "$KUBOT_LIDAR_INPUT" = "s1" ]; then
    KUBOT_LIDAR='two-rplidar-a2'
else
    KUBOT_LIDAR=$KUBOT_LIDAR_INPUT
fi

# Specify  kubot camera
tput setaf 2
echo "Please specify  kubot camera:"
tput setaf 3
echo "
    0 : not config
    1 : xtion
    2 : astra
    3 : kinectV2
    4 : intel realsense(d435i)
    5 : logitech(c615)
    "
tput sgr0

read -p "" KUBOT_CAMERA_INPUT

if [ "$KUBOT_CAMERA_INPUT" = "0" ]; then
    KUBOT_CAMERA='non-camera'
    KUBOT_DEEP_CAM=0
elif [ "$KUBOT_CAMERA_INPUT" = "1" ]; then
    KUBOT_CAMERA='xtion'
    KUBOT_DEEP_CAM=1
elif [ "$KUBOT_CAMERA_INPUT" = "2" ]; then
    KUBOT_CAMERA='astra'
    KUBOT_DEEP_CAM=1
elif [ "$KUBOT_CAMERA_INPUT" = "3" ]; then
    KUBOT_CAMERA='kinectV2'
    KUBOT_DEEP_CAM=1
elif [ "$KUBOT_CAMERA_INPUT" = "4" ]; then
    KUBOT_CAMERA='d435i'
    KUBOT_DEEP_CAM=1
elif [ "$KUBOT_CAMERA_INPUT" = "5" ]; then
    KUBOT_CAMERA='logi-c615'
    KUBOT_DEEP_CAM=0
else
    KUBOT_CAMERA=$KUBOT_CAMERA_INPUT
    KUBOT_DEEP_CAM=0
fi

# Specify  the current machine
tput setaf 2
echo "Please specify the current machine(ip:$LOCAL_IP) type:"
tput setaf 3
echo "
    0 : Master 
    1 : Slaver
    "
tput sgr0

read -p "" KUBOT_MACHINE_VALUE
if [ "$KUBOT_MACHINE_VALUE" = "0" ]; then
    tput setaf 3
    ROS_MASTER_IP_STR="\`echo \$LOCAL_IP\`"
    ROS_MASTER_IP=$(echo $LOCAL_IP)
    tput sgr0
else
    tput setaf 2
    echo "Plase specify the robot_ip for commnication:"
    tput setaf 7
    read -p "" KUBOT_SLAVER_IP
    tput setaf 3
    ROS_MASTER_IP_STR=$(echo $KUBOT_SLAVER_IP)
    ROS_MASTER_IP=$(echo $KUBOT_SLAVER_IP)
    tput sgr0
fi

# Export the settings in kubotros1rc
echo "export KUBOT_MODEL=${KUBOT_MODEL}" >>~/.kubotros1rc
echo "export KUBOT_MODEL_TYPE=${KUBOT_MODEL_TYPE}" >>~/.kubotros1rc
echo "export KUBOT_BOARD=${KUBOT_BOARD}" >>~/.kubotros1rc
echo "export KUBOT_DRIVER_BAUDRATE=${KUBOT_DRIVER_BAUDRATE}" >>~/.kubotros1rc
echo "export KUBOT_LIDAR=${KUBOT_LIDAR}" >>~/.kubotros1rc
echo "export KUBOT_CAMERA=${KUBOT_CAMERA}" >>~/.kubotros1rc
echo "export KUBOT_DEEP_CAM=${KUBOT_DEEP_CAM}" >>~/.kubotros1rc
echo "export ROS_MASTER_URI=$(echo http://${ROS_MASTER_IP_STR}:11311)" >>~/.kubotros1rc
echo "export ROS_IP=\`echo \$LOCAL_IP\`" >>~/.kubotros1rc
echo "export ROS_HOSTNAME=\`echo \$LOCAL_IP\`" >>~/.kubotros1rc

# View current settings
tput setaf 5
echo "*****************************************************************"
tput setaf 4
echo " KUBOT Robot Model:" $KUBOT_MODEL
echo " Driver Board:" $KUBOT_BOARD
echo " Lidar:" $KUBOT_LIDAR
echo " Camera:" $KUBOT_3DSENSOR
echo " ros1_local_ip:" ${LOCAL_IP}
echo " ros1_robot_ip:" ${ROS_MASTER_IP}
echo ""
tput setaf 3
echo "Please execute source ~/.bashrc to make the configure effective."
tput setaf 5
echo "*****************************************************************"

# Content Source KUBOT workspace
tput setaf 2
echo "Content Source KUBOT workspace..."
tput sgr0

content="#source KUBOT workspace
if [ ! -f ~/kubot_ros/ros_ws/devel/setup.bash ]; then 
    echo \"please run cd ~/kubot_ros/ros_ws && catkin_make to compile kubot sdk\"
else
    source ~/kubot_ros/ros_ws/devel/setup.bash
fi
"
echo "${content}" >>~/.kubotrc

# Export the Alias settings
echo " " >>~/.kubotros1rc
echo "alias kubot_bringup='roslaunch kubot_bringup bringup.launch'" >>~/.kubotros1rc
echo "alias kubot_keyboard='roslaunch kubot_control keyboard_teleop.launch'" >>~/.kubotros1rc
echo "alias kubot_robot='roslaunch kubot_bringup robot.launch'" >>~/.kubotros1rc

echo "alias kubot_rqt='rosrun rqt_reconfigure rqt_reconfigure' " >>~/.kubotros1rc
echo "alias kubot_motor_run='rostopic pub cmd_vel linear x:0.2 y:0.0 z:0.0 angular x:0.0 y:0.0 z:0.0 -r 20'" >>~/.kubotros1rc
echo "alias kubot_motor_show='rosrun rqt_plot rqt_plot /motor1_input /motor1_output /motor2_input /motor2_output'" >>~/.kubotros1rc
echo "alias kubot_linear='rosrun kubot_control calibrate_linear.py'" >>~/.kubotros1rc
echo "alias kubot_angular='rosrun kubot_control calibrate_angular.py'" >>~/.kubotros1rc

echo "alias kubot_gmp='roslaunch kubot_slam_2d gmapping.launch'" >>~/.kubotros1rc
echo "alias kubot_save_map='roslaunch kubot_navigation save_map.launch'" >>~/.kubotros1rc
echo "alias kubot_view='roslaunch kubot_navigation view_nav.launch'" >>~/.kubotros1rc

# Finish Initialize kubot_ros1
tput setaf 2
echo "Finish Initialize kubot_ros1!"
tput sgr0

# tput setaf $Number
# Red is 1
# Green is 2
# Yallow is 3
# Blue is 4
# Purple is 5
# Cyan-blue is 6
# White is 7
# Gray is 8
# Reset is sgr0

# KUBOT_ROS1
