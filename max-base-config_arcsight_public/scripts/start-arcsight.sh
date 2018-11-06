#!/bin/bash

## start-arcsight.sh
## kvice 9/12/2018
## Starts ArcSight EMS 7 services
## Currently configured to run manually on SIEM server

## Run this script on the SIEM server as the admin user

# Start services
sudo /opt/arcsight/manager/bin/setup_services.sh

# END