# Use upstream melodic images as base
FROM ros:melodic-ros-base-bionic AS bitbots-builder

# Install
RUN apt-get update; \
    apt-get install -y python3-pip; \
    python3 -m pip install catkin-tools catkin-pkg trollius

RUN . /opt/ros/melodic/setup.sh; \
    mkdir -p /catkin_ws/src; cd /catkin_ws; \
    catkin init; \
    catkin config \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DPYTHON_INCLUDE_DIR=/usr/include/python3.7m \
        -DPYTHON_LIBRARY=/usr/lib/libpython3.7m.so; \
    catkin build; \
    chmod -R 777 /catkin_ws;

COPY scripts /opt/bitbots_scripts
