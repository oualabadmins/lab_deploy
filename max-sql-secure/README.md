# MAX Skunkworks Lab - SQL Azure Secure Configuration - Public (v0.2)

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

+ **SQL Azure instance**: SQL Azure server.
+ **Storage account**: Advanced Data Security storage account.
+ **NSG**: Network security group configured to allow VNet access and specified inbound IP/range.
+ **Virtual network**: Virtual network for internal traffic, configured 2 tenant subnets.
+ **Public IP addresses**: 1 static public IP for the service endpoint.

## Solution notes

## Known issues
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _7/9/2019_

## Changelog

+ **7/9/2019**: Original commit
