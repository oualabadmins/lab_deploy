#!/bin/bash

## siemconfig.sh
## kvice 9/12/2018
## Configures a CentOS Linux host with ArcSight EMS
## Currently configured to run manually on SIEM server
## 10/31/2018 - Tested successfully, although enabling arcsight user to connect to VNC was still problematic. May have to reboot after adding arcsight user.

# Set SELinux enforcement to permissive
setenforce 0

# Allow root to open GUI apps as sudo (run from non-root console): xhost +local:
# sudo persistent (if running manually): sudo -s

# Add .vnc to /etc/skel to enable VNC config for new users
mkdir /etc/skel/.vnc

# Create arcsight user
mkdir /home/arcsight
groupadd arcsight
username="arcsight"
password="arcsight"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -c “arcsight_software_owner” -g arcsight -d /home/arcsight -p $pass -m -s /bin/bash arcsight
cd /home/arcsight/
cp -r /etc/skel/. .
chown -R arcsight.arcsight .
chmod -R go=u,go-w .
chmod go= .

# Restart xrdp to allow arcsight to login
service xrdp restart

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
ulimit -a
# Check for the following two lines:
#open files 65536
#max user processes 10240

# Expand /dev/sda2 to max (use gparted to do this manually, does not require reboot!)
fdisk /dev/sda p d 2 n p 2 w q
reboot
# post reboot
xfs_growfs /dev/sda2

# Install ESM
## NOTE: login as arcsight user
cd /arcsight/arcsight_install/
chmod +x ArcSightESMSuite.bin
./ArcSightESMSuite.bin

# Start services
## NOTE: login as oualabadmin, sudo -s for root
 /opt/arcsight/manager/bin/setup_services.sh

# END
