#!/bin/bash

## initialconfig.sh
## kvice 9/12/2018
## Configures a CentOS Linux host with xrdp, Mate, and other basic config tasks
## Takes params: admin username $1, password $2

# Set SELinux enforcement to permissive
setenforce 0

# Apply all available updates, omit Azure agent to prevent script failure
yum update -y --exclude=WALinuxAgent

# Install foundation packages
yum install epel-release -y
yum -y --enablerepo epel install xrdp tigervnc-server
yum -y groupinstall "MATE Desktop"
yum install byobu -y

# Set GUI autostart
systemctl isolate graphical.target
systemctl set-default graphical.target

# Configure SELinux for xrdp
chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

# Start and enable xrdp
service xrdp start
systemctl enable xrdp.service

# Set up Mate desktop for builtin admin user
echo "exec mate-session" > /home/$1/.Xclients
chmod 700 /home/$1/.Xclients

# Set up Mate desktop for all users
echo "exec mate-session" > /etc/skel/.Xclients
chmod 700 /etc/skel/.Xclients

# Update time zone
yum -y update tzdata
timedatectl set-timezone America/Los_Angeles

# Mount data disk /dev/sdc1 as /arcsight
parted /dev/sdc mklabel msdos
parted -s -a optimal /dev/sdc mkpart primary xfs 1MiB 1000MiB
mkfs.xfs -L /arcsight -q /dev/sdc1
mkdir /arcsight
mount /dev/sdc1 /arcsight
cp /etc/fstab /etc/fstab.old
echo -e "/dev/sdc1 /arcsight xfs defaults 0 0" >> /etc/fstab

# Restart
reboot -f
#shutdown -r now