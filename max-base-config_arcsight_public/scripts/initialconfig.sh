#!/bin/bash

## initialconfig.sh
## kvice 9/12/2018
## Configures a CentOS Linux host with xrdp, Mate, and other basic config tasks
## 10/30/2018 - Updated dev\sdc1 size from 1000MiB to 1000000MiB (1TB)
## 10/31/2018 - Cleaned up unused lines, remmed yum update

# Set SELinux enforcement to permissive
setenforce 0

# Apply all available updates, omit Azure agent to prevent script failure
#yum update -y --exclude=WALinuxAgent

# Install foundation packages
yum -y install epel-release
yum -y --enablerepo epel install xrdp tigervnc-server
yum -y groupinstall "MATE Desktop"
yum -y install byobu
yum -y install gedit

# Set GUI autostart
systemctl isolate graphical.target
systemctl set-default graphical.target

# Configure SELinux for xrdp
chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

# Start and enable xrdp
service xrdp start
systemctl enable xrdp.service

# Set up Mate desktop
echo "PREFERRED=/usr/bin/mate-session" > /etc/sysconfig/desktop

# Update time zone
yum -y update tzdata
timedatectl set-timezone America/Los_Angeles

# Mount data disk /dev/sdc1 as /arcsight
parted /dev/sdc mklabel msdos
parted -s -a optimal /dev/sdc mkpart primary xfs 1MiB 1000000MiB
mkfs.xfs -L /arcsight -q /dev/sdc1
mkdir /arcsight
mount /dev/sdc1 /arcsight
cp /etc/fstab /etc/fstab.old
echo -e "/dev/sdc1 /arcsight xfs defaults 0 0" >> /etc/fstab
