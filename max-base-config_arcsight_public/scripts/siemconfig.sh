#!/bin/bash

## siemconfig.sh
## kvice 9/12/2018
## Configures a CentOS Linux host with ArcSight EMS
## Currently configured to run manually on SIEM server

# Set SELinux enforcement to permissive
setenforce 0

## Install ArcSight EMS
# From https://www.slideshare.net/Protect724/esm-install-guide60c

# Create arcsight user
mkdir /home/arcsight
groupadd arcsight
username="arcsight"
password=""
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -c “arcsight_software_owner” -g arcsight -d "/home/arcsight" -p $pass $username
/home/arcsight -m -s /bin/bash arcsight

# Install dependencies
yum -y groupinstall "Web Server", "Compatibility Libraries", "Development Tools"

# Disable IPv6 per https://community.softwaregrp.com/t5/ArcSight-User-Discussions/Fresh-ESM-Installation-stops-at-quot-Set-up-ArcSight-Storage/td-p/1519539
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1

# Create install folder, chown to arcsight
mkdir -m777 arcsight_install
cd arcsight_install
tar xvf ArcSightESMSuite-7.0.0.xxxx.1.tar
chown -R arcsight:arcsight .

# Run prepare_system.sh
cd Tools
./prepare_system.sh

# Install ESM as arcsight user
su arcsight
./ArcSightESMSuite.bin -i console



# Start services
 /opt/arcsight/manager/bin/setup_services.sh


# FINAL
