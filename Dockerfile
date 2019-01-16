# Use upstream melodic images as base
FROM ros:melodic-ros-base-bionic AS bitbots-builder

ARG uid=1001
ARG gid=1001

# Install system dependencies
RUN apt-get update; \
    apt-get install -y python3-pip; \
    python3 -m pip install catkin-tools catkin-pkg trollius

# Setup permissions for rosdep
RUN apt-get install -y sudo; \
    echo "Group = $gid"; groupadd -g $gid builder; \
    echo "User = $uid"; useradd -M -u $uid -g $gid builder; \
    echo "$uid   ALL= NOPASSWD:  /usr/bin/rosdep *" >> /etc/sudoers

# Setup catkin workspace
RUN . /opt/ros/melodic/setup.sh; \
    mkdir -p /catkin_ws/src; cd /catkin_ws; \
    catkin init; \
    catkin config \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DPYTHON_INCLUDE_DIR=/usr/include/python3.7m \
        -DPYTHON_LIBRARY=/usr/lib/libpython3.7m.so; \
    catkin build; \
    chmod -R 777 /catkin_ws;

# Add our scripts for convenience
#COPY scripts /opt/bitbots_scripts
