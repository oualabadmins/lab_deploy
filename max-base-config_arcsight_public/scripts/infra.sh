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

## kvice additions

# Basic updates
sed -i '.old' '/ppa.launchpad.net/{s/^/#/}' sources.list
sudo apt upgrade --allow-unauthenticated
sudo apt update --allow-unauthenticated
sudo apt-get update && sudo apt-get install build-essential
sudo apt-get install gedit

## Install ArcSight EMS