#!/bin/bash
# Install Robot Operating System (ROS1) on ubuntu system.
# Maintainer of ARM builds for ROS is http://answers.ros.org/users/1034/ahendrix/
# Information from:
# http://wiki.ros.org/ROS/Installation/UbuntuMirrors

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

# Let's start installing ROS!
tput setaf 5
echo "Let's start installing ROS1..."
tput sgr0

# Adding repository and source list
tput setaf 2
echo "Adding repository and source list..."
tput sgr0

sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted

if [ "$ROS_VERSION" = "melodic" ] || [ "$ROS_VERSION" = "noetic" ] ; then

    # Setup sources.lst
    tput setaf 2
    echo "Setup sources.lst..."
    tput sgr0

    if [ "$SYS_KERNEL" = arm ]; then
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    else
        sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    fi

    # Setup keys
    sudo apt install curl 
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    # Updating apt-get
    tput setaf 2
    echo "Updating apt-get..."
    tput sgr0

    sudo apt-get update

    # Choes ros package
    tput setaf 2
    echo "Please specify ROS package:"
    tput setaf 3
    echo "
    1 : Desktop-Full Install (ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators and 2D/3D perception)
    2 : Desktop Install (ROS, rqt, rviz, and robot-generic libraries)
    3 : ROS-Base (ROS package, build, and communication libraries. No GUI tools.)
    "
    tput sgr0

    read -p "" ROS_TOOL

    if [ "$ROS_TOOL" = "1" ]; then
        sudo apt-get install ros-${ROS_VERSION}-desktop-full -y
    elif [ "$ROS_TOOL" = "2" ]; then
        sudo apt-get install ros-${ROS_VERSION}-desktop -y
    else
        sudo apt-get install ros-${ROS_VERSION}-ros-base -y
    fi

    # Initialize rosdep
    tput setaf 2
    echo "Installing rosdep"
    tput sgr0

    if [ "$ROS_VERSION" = "melodic" ]; then
        sudo apt-get install git python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y
    elif [ "$ROS_VERSION" = "noetic" ]; then
        sudo apt-get install git python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
    else
        exit
    fi

    # Initialize rosdep
    tput setaf 2
    echo "Initializaing rosdep"
    tput sgr0

    sudo rosdep init
    rosdep update

    # Finish Install ROS1
    tput setaf 2
    echo "Finish Install ROS1"
    tput sgr0

    grep -q -F 'source /opt/ros/melodic/setup.bash' ~/.bashrc || echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    source ~/.bashrc
else
    exit
fi

# KUBOT_ROS1
