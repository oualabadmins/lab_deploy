#!/bin/bash

## Install and configure xrdp

# Set enforcement to permissive
setenforce 0

# Install foundation packages
#wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install epel-release
yum -y --enablerepo epel install xrdp tigervnc-server
yum -y --enablerepo epel install mate-desktop
yum -y install mailx tcpdump

# Set autostart
systemctl isolate graphical.target
systemctl set-default graphical.target

# Set up Mate desktop for builtin admin user
echo "exec mate-session" > ~/.Xclients
chmod 700 ~/.Xclients

# Set up Mate desktop for all users
echo "exec mate-session" > /etc/skel/.Xclients
chmod 700 /etc/skel/.Xclients

# Apply updates, omit Azure agent to prevent script failure
yum update -y --exclude=WALinuxAgent

# Configure SELinux
chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

# Start and enable xrdp ##### REMMED TO SEE IF NEEDED
#service xrdp start
#systemctl enable xrdp.service
#systemctl start graphical.target

# Update time zone
yum -y update tzdata
timedatectl set-timezone America/Los_Angeles

##### FOLLOWING REMMED OUT UNTIL ARCSIGHT INSTALL SCRIPTS ARE AVAILABLE #####

## Install ArcSight EMS
# From https://www.slideshare.net/Protect724/esm-install-guide60c

# Install dependencies
#yum -y groupinstall "Web Server", "Compatibility Libraries", "Development Tools"
#yum -y install pam

# Create arcsight user
#groupadd arcsight
#username="arcsight"
#password="$3rv1c3"
#pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
#useradd -c “arcsight_software_owner” -g arcsight -d -p $pass $username
#/home/arcsight -m -s /bin/bash arcsight

# Disable IPv6 per https://community.softwaregrp.com/t5/ArcSight-User-Discussions/Fresh-ESM-Installation-stops-at-quot-Set-up-ArcSight-Storage/td-p/1519539
#sysctl -w net.ipv6.conf.default.disable_ipv6=1
#sysctl -w net.ipv6.conf.all.disable_ipv6=1

# Create install folder, chown to arcsight
#mkdir -m777 arcsight_install
#cd arcsight_install
#tar xvf ArcSightESMSuite-7.0.0.xxxx.1.tar
#chown -R arcsight:arcsight .

# Run prepare_system.sh
#cd Tools
#./prepare_system.sh

# Install ESM as arcsight user
#su arcsight
#./ArcSightESMSuite.bin -i console



# Start services
# /opt/arcsight/manager/bin/setup_services.sh