FROM ubuntu:14.04

RUN apt update && apt install -y sudo 

RUN useradd -g video --create-home --shell /bin/bash rishabh && \
		echo "rishabh ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/rishabh && \
		chmod 0400 /etc/sudoers.d/rishabh

USER rishabh
WORKDIR /home/rishabh

RUN sudo apt update && sudo apt install -y apt-utils tmux vim lsb-release

RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
		sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 && \
		sudo apt update && \
		sudo apt install -y ros-indigo-desktop-full && \
		echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc

RUN sudo apt update && sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt update && \
                sudo apt install -y liburdfdom-tools \

                        evince \

                        kmod \

                        iproute

# install the nvidia driver
RUN sudo apt update && \
                sudo apt install -y mesa-utils binutils
ADD NVIDIA-DRIVER.run /tmp/NVIDIA-DRIVER.run
RUN sudo sh /tmp/NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module
RUN sudo rm /tmp/NVIDIA-DRIVER.run

RUN sudo rosdep init

RUN rosdep update

#ADD localConfig /home/warrierr/localConfig
#ENTRYPOINT "./localConfig" && /bin/bash


RUN sudo apt-get install -y ros-indigo-move-base \
		            ros-indigo-rosserial 
