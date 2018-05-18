FROM osrf/ros:kinetic-desktop-full

RUN apt-get update && apt-get install -y python-rosdep \
    python-catkin-tools \
    apt-utils

RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc

RUN mkdir -p /root/create_ws/src

WORKDIR /root/create_ws

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin init" 

WORKDIR /root/create_ws/src

RUN git clone https://github.com/AutonomyLab/create_autonomy.git 

WORKDIR /root/create_ws

RUN /bin/bash -c "rosdep update"

RUN /bin/bash -c "rosdep install -y --from-paths src -i" 

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin build" 

RUN usermod -a -G dialout root
