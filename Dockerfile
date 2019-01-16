# Use upstream melodic images as base
FROM ubuntu:bionic AS bitbots-builder

RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-final.list \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 5523BAEEB01FA116

COPY scripts /opt/bitbots_scripts

RUN apt-get update; \
    apt-get install -y python3-catkin-tools python3-catkin-pkg ros-melodic-catkin

RUN . /opt/ros/melodic/setup.sh; \
    mkdir -p /catkin_ws/src; cd /catkin_ws; \
    catkin init; \
    catkin config \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DPYTHON_INCLUDE_DIR=/usr/include/python3.7m \
        -DPYTHON_LIBRARY=/usr/lib/libpython3.7m.so; \
    catkin build;
