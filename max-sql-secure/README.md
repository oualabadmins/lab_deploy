# MAX Skunkworks Lab - SQL Azure Secure Configuration - Public (v0.1)

**IMPORTANT**: Only deploy this template into an external-facing subscription with no ExpressRoute circuit. These currently include:

+ MAXLAB R&D Sandbox
+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2

**Time to deploy**: 40+ minutes

The **SQL Azure Secure Configuration** provisions a SQL Azure instance with two private virtual networks with a service endpoint.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-sql-secure%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-sql-secure%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **SQL Azure instance**: SQL Azure server with one database.
+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated. ADDC and App Server VMs in the deployment use managed disks, so no storage accounts are created for VHDs.
+ **NSG**: Network security group configured to allow inbound RDP on 3389
+ **Virtual network**: Virtual network for internal traffic, configured with custom DNS pointing to the ADDC's private IP address and 2 tenant subnets, _subnet-frontend_ and _subnet-backend_.
+ **Network interfaces**: 1 NIC per VM (AD and CLIENT), 2 NICs per APP VM
+ **Public IP addresses**: 1 static public IP per VM. Note that some subscriptions may have limits on the number of static IPs that can be deployed for a given region.

## Solution notes

## Known issues
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](https://github.com/oualabadmins/lab_deploy/common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _7/9/2019_

## Changelog

+ **7/9/2019**: Original commit