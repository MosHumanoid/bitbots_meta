# Use upstream melodic images as base
FROM ros:melodic-ros-core

COPY scripts /opt/bitbots_scripts

RUN apt-get update; \
    apt-get install -y python-catkin-tools
