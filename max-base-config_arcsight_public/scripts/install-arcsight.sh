#!/bin/bash

## install-arcsight.sh
## kvice 9/12/2018
## Installs ArcSight EMS 7
## Currently configured to run manually on SIEM server
## 11/6/2018 - Restructured, moved arcsight install to install-arcsight.sh

## Run this script on the SIEM server as the arcsight user

# Confirm setup
ulimit -a
# Check to make sure the following two lines read as follows:
# open files 65536
# max user processes 10240

# Install ESM in console mode (GUI mode is not reliable)
cd /arcsight/arcsight_install/
chmod +x ArcSightESMSuite.bin
./ArcSightESMSuite.bin -i console

# END