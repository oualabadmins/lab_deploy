#!/bin/bash

## Install and configure xrdp

# Set enforcement to permissive
setenforce 0

# Install xfce4
#rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

# Install xrdp
#yum -y --enablerepo epel install xrdp tigervnc
#yum -y --enablerepo epel install xrdp tigervnc-server

# Set firewall permit rules (remmed: firewalld not running by default)
#firewall-cmd -–add-port=3350/tcp -–permanent 
#firewall-cmd -–permanent -–add-port=3389/tcp
#firewall-cmd -–permanent -–add-port=5900/tcp
#firewall-cmd -–permanent -–add-port=5910/tcp
#firewall-cmd –reload

## NEW - Install X foundation
yum -y install epel-release
yum -y groupinstall "X Window system"
yum -y groupinstall "MATE Desktop"

# Set autostart
systemctl set-default graphical.target

# Set up Mate desktop for builtin admin user
echo "exec mate-session" > ~/.Xclients
chmod 700 ~/.Xclients

# Set up Mate desktop for all users
echo "exec mate-session" > /etc/skel/.Xclients
chmod 700 /etc/skel/.Xclients

# Apply updates
yum -y update

# Configure SELinux
chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

# Start and enable xrdp
systemctl start xrdp.service
systemctl enable xrdp.service

## Install ArcSight EMS
# From https://www.slideshare.net/Protect724/esm-install-guide60c

# Disable IPv6 per https://community.softwaregrp.com/t5/ArcSight-User-Discussions/Fresh-ESM-Installation-stops-at-quot-Set-up-ArcSight-Storage/td-p/1519539
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1

# Install dependencies
yum -y groupinstall "Web Server", "Compatibility Libraries", "Development Tools"
yum -y install pam

# Create arcsight user
groupadd arcsight
username="arcsight"
password="$3rv1c3"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -c “arcsight_software_owner” -g arcsight -d -p $pass $username
/home/arcsight -m -s /bin/bash arcsight

# Run prepare_system.sh

# Login as arcsight user

# Verify settings
ulimit -a