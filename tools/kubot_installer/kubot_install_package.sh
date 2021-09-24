#!/bin/bash
# Clone ALL KUBOT Robot ROS1 Package and ROS1 dependencies.

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

# Clone KUBOT Robot ALL package and Third party package
tput setaf 2
echo "Clone KUBOT Robot ALL Package and Third Party Package..."
tput sgr0

cd ~/kubot_ros1/ros_ws/src/
git clone https://github.com/kubot080301/kubot_base_driver.git -b $ROS_VERSION-devel
git clone https://github.com/kubot080301/kubot_description.git -b $ROS_VERSION-devel
git clone https://github.com/kubot080301/kubot_gazebo.git -b $ROS_VERSION-devel
git clone https://github.com/kubot080301/kubot_2d_slam.git -b $ROS_VERSION-devel
git clone https://github.com/kubot080301/kubot_navigation.git -b $ROS_VERSION-devel
git clone https://github.com/kubot080301/kubot_3d_slam.git -b $ROS_VERSION-devel

mkdir third_party_pkg

git clone https://github.com/kubot080301/rplidar_ros.git
git clone https://github.com/tu-darmstadt-ros-pkg/hector_slam.git
git clone https://github.com/orbbec/ros_astra_launch.git
git clone https://github.com/orbbec/ros_astra_camera.git

# Install KUBOT ROS1 Package dependencies
tput setaf 2
echo "Install KUBOT ROS1 Package dependencies..."
tput sgr0

sudo apt-get -y --allow-unauthenticated install ros-${ROS_VERSION}-ros-base \
    ros-${ROS_VERSION}-slam-gmapping \
    ros-${ROS_VERSION}-navigation \
    ros-${ROS_VERSION}-xacro \
    ros-${ROS_VERSION}-laser-filters \
    ros-${ROS_VERSION}-robot-state-publisher \
    ros-${ROS_VERSION}-joint-state-publisher \
    ros-${ROS_VERSION}-joint-state-publisher-gui \
    ros-${ROS_VERSION}-teleop-twist-* \
    ros-${ROS_VERSION}-control-msgs \
    ros-${ROS_VERSION}-kdl-parser-py \
    ros-${ROS_VERSION}-tf2-geometry-msgs \
    ros-${ROS_VERSION}-usb-cam \
    ros-${ROS_VERSION}-image-transport \
    ros-${ROS_VERSION}-image-transport-plugins \
    ros-${ROS_VERSION}-depthimage-to-laserscan \
    ros-${ROS_VERSION}-openni2* \
    ros-${ROS_VERSION}-freenect-* \
    ros-${ROS_VERSION}-robot-upstart \
    ros-${ROS_VERSION}-tf-conversions \
    ros-${ROS_VERSION}-orocos-kdl \
    ros-${ROS_VERSION}-camera-umd \
    ros-${ROS_VERSION}-libuvc* \
    ros-${ROS_VERSION}-camera-calibration \
    ros-${ROS_VERSION}-timed-roslaunch \
    ros-${ROS_VERSION}-web-video-server \
    ros-${ROS_VERSION}-robot-pose-ekf \
    ros-${ROS_VERSION}-ira-laser-tools \
    ros-${ROS_VERSION}-yocs-velocity-smoother \
    ros-${ROS_VERSION}-slam-karto \
    ros-${ROS_VERSION}-hector-mapping \
    ros-${ROS_VERSION}-hector-geotiff \
    ros-${ROS_VERSION}-hector-trajectory-server \
    ros-${ROS_VERSION}-realsense2-camera \
    ros-${ROS_VERSION}-rtabmap* \
    ros-${ROS_VERSION}-cartographer-ros \
    ros-${ROS_VERSION}-cartographer-rviz

cd ~/kubot_ros1/ros_ws/
rosdep update
rosdep install --from-paths src --ignore-src -r -y --rosdistro $ROS_VERSION

# KUBOT_ROS1
