#!/bin/bash

logger -t devvm "Install started: $?"
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
apt-get install -y apt-transport-https

# Install Azure CLI
apt-get update && sudo apt-get install -y azure-cli
logger -t devvm "Azure-cli installed: $?"
sudo apt-get -y update

# Install XRDP with Mate
sudo apt-get -q=2 -y install xrdp
logger -t devvm "XRDP installed: $?"
logger -t devvm "Installing Mate Desktop ..."
sudo dpkg --configure -a
sudo apt-add-repository -y ppa:ubuntu-mate-dev/ppa
sudo apt-add-repository -y ppa:ubuntu-mate-dev/trusty-mate
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -q=2  --no-install-recommends -m ubuntu-mate-core
sudo apt-get install -q=2  --no-install-recommends -m ubuntu-mate-desktop
logger -t devvm "Mate Desktop installed. $?"
echo mate-session >~/.xsession
sudo service xrdp restart

# Fixes issue with Ubuntu desktop being blank
sudo sed -i -e 's/console/anybody/g' /etc/X11/Xwrapper.config
logger -t devvm "Mate Desktop configured. $?"
logger -t devvm "Installing VSCode: $?"

# Install VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install -y code
logger -t devvm "VSCode Installed: $?"
logger -t devvm "Success"
exit 0

## kvice additions 7/24/2018

# Basic updates
sed -i '.old' '/ppa.launchpad.net/{s/^/#/}' sources.list
sudo apt upgrade --allow-unauthenticated
sudo apt update --allow-unauthenticated
sudo apt-get update && sudo apt-get install build-essential
sudo apt-get install gedit

# Install ROS Kinetic
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
sudo apt-get install python-rosinstall

# Create dev workspace
mkdir -p ~/ros_ws/src
source /opt/ros/kinetic/setup.bash
cd ~/ros_ws
catkin_make

# Install Intera SDK dependencies
sudo apt-get update
sudo apt-get install git-core python-argparse python-wstool python-vcstools python-rosdep ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs ros-kinetic-rospy-message-converter

# Install Intera Robotics SDK
cd ~/ros_ws/src
wstool init .
git clone https://github.com/RethinkRobotics/sawyer_robot.git
wstool merge sawyer_robot/sawyer_robot.rosinstall
wstool update
source /opt/ros/kinetic/setup.bash
cd ~/ros_ws
catkin_make

# Intera ROS environment setup
cp ~/ros_ws/src/intera_sdk/intera.sh ~/ros_ws
# Now follow intera.sh ROS Environment Setup at http://sdk.rethinkrobotics.com/intera/Workstation_Setup

# Install Gazebo
sudo apt-get install gazebo7 ros-kinetic-qt-build ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-control-toolbox ros-kinetic-realtime-tools ros-kinetic-ros-controllers ros-kinetic-xacro python-wstool ros-kinetic-tf-conversions ros-kinetic-kdl-parser ros-kinetic-sns-ik-lib

# Install Sawyer simulator
mkdir -p ~/ros_ws/src
cd ~/ros_ws/src
git clone https://github.com/RethinkRobotics/sawyer_simulator.git
cd ~/ros_ws/src
wstool init .
wstool merge sawyer_simulator/sawyer_simulator.rosinstall
wstool update

source /opt/ros/kinetic/setup.bash
cd ~/ros_ws
catkin_make
# Now follow Simulation at http://sdk.rethinkrobotics.com/intera/Gazebo_Tutorial

# Install Rviz
rosrun rviz rviz

# Install Moveit
sudo apt-get update
sudo apt-get install ros-kinetic-moveit
cd ~/ros_ws/
./intera.sh
cd ~/ros_ws/src
wstool merge https://raw.githubusercontent.com/RethinkRobotics/sawyer_moveit/master/sawyer_moveit.rosinstall
wstool update
cd ~/ros_ws/
catkin_make