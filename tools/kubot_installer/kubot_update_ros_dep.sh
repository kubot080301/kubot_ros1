    cd ~/kubot_ros1/ros_ws/
    rosdep update
    rosdep install --from-paths src --ignore-src -r -y --rosdistro melodic


        #cd ~/kubot_ros/ros_ws/src/kubot_tools
    #git clone https://github.com/tu-darmstadt-ros-pkg/hector_slam.git
    #git clone https://github.com/orbbec/ros_astra_launch.git
    #git clone https://github.com/orbbec/ros_astra_camera.git
    #git clone https://github.com/ros-drivers/openni2_camera.git
    #git clone https://github.com/ros-drivers/freenect_stack.git
    
    #sudo apt-get -y --allow-unauthenticated install ros-${ros_version}-ros-base  \
            #    ros-${ros_version}-yocs-velocity-smoother \
            #    ros-${ros_version}-slam-karto  \
            #    ros-${ros_version}-hector-mapping \
            #    ros-${ros_version}-hector-geotiff  \
            #    ros-${ros_version}-hector-trajectory-server \
            #    ros-${ros_version}-realsense2-camera \
		    #    ros-${ros_version}-rtabmap* \
		    #    ros-${ros_version}-cartographer-ros \
		    #    ros-${ros_version}-cartographer-rviz \

    cd ..

    sudo apt-get -y --allow-unauthenticated install ros-${ros_version}-ros-base  \
                ros-${ros_version}-slam-gmapping \
                ros-${ros_version}-navigation \
                ros-${ros_version}-xacro \
                ros-${ros_version}-laser-filters \
                ros-${ros_version}-robot-state-publisher \
                ros-${ros_version}-joint-state-publisher \
            	ros-${ros_version}-joint-state-publisher-gui \
                ros-${ros_version}-teleop-twist-* \
                ros-${ros_version}-control-msgs \
                ros-${ros_version}-kdl-parser-py \
                ros-${ros_version}-tf2-geometry-msgs \
                ros-${ros_version}-usb-cam  \
                ros-${ros_version}-image-transport \
                ros-${ros_version}-image-transport-plugins \
                ros-${ros_version}-depthimage-to-laserscan \
                ros-${ros_version}-openni2* \
                ros-${ros_version}-freenect-* \
                ros-${ros_version}-robot-upstart \
                ros-${ros_version}-tf-conversions \
                ros-${ros_version}-orocos-kdl \
                ros-${ros_version}-camera-umd \
		        ros-${ros_version}-libuvc* \
                ros-${ros_version}-camera-calibration \
                ros-${ros_version}-timed-roslaunch \
                ros-${ros_version}-web-video-server \
		        ros-${ros_version}-robot-pose-ekf 
else
    exit
fi
