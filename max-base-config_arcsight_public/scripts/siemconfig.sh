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
useradd -c “arcsight_software_owner” -g arcsight -d /home/arcsight -p $pass $username -m -s /bin/bash arcsight
/home/arcsight -m -s /bin/bash arcsight

# Install dependencies
yum -y groupinstall "Web Server", "Compatibility Libraries", "Development Tools"

# Disable IPv6 per https://community.softwaregrp.com/t5/ArcSight-User-Discussions/Fresh-ESM-Installation-stops-at-quot-Set-up-ArcSight-Storage/td-p/1519539
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1

# Mount SMB file share //maxfilesext2.file.core.windows.net/arcsight
mkdir -p /mnt/maxfilesext2
mount -t cifs //maxfilesext2.file.core.windows.net/arcsight /mnt/maxfilesext2 -o vers=3.0,username=maxfilesext2,password=yqIHW9FzyyMGCN+CDeHFzsITUFdC0k4xq/Wa0G7bqIxVOJyQtFoA1BM/9V0C6k+P3U9KaI98sDeeh8G4vSNa4A==,dir_mode=0777,file_mode=0777,sec=ntlmssp
echo -e "//maxfilesext2.file.core.windows.net/arcsight /mnt/maxfilesext2 cifs vers=3.0,username=maxfilesext2,password=yqIHW9FzyyMGCN+CDeHFzsITUFdC0k4xq/Wa0G7bqIxVOJyQtFoA1BM/9V0C6k+P3U9KaI98sDeeh8G4vSNa4A==,dir_mode=0777,file_mode=0777" >> /etc/fstab

# Create install folder, chown to arcsight
mkdir -m777 /arcsight/arcsight_install
cd /arcsight/arcsight_install

# Copy install bits from CIFS share to /arcsight/arcsight_install
cp /mnt/maxfilesext2/linux/* /arcsight/arcsight_install/
tar xvf ArcSightESMSuite-7.0.0.2234.1.tar
chown -R arcsight:arcsight .

# Run prepare_system.sh
cd Tools
./prepare_system.sh

#### REBOOT SYSTEM NOW

# Confirm setup
sudo ulimit -a
# Check for the following two lines:
#open files 65536
#max user processes 10240


# Install ESM as arcsight user
su arcsight
./ArcSightESMSuite.bin -i console



# Start services
 /opt/arcsight/manager/bin/setup_services.sh


# FINAL
