# Skunkworks Lab - Add client VMs to existing deployment

**Time to deploy**: 10 minutes

The **Add client VMs to existing deployment** template provisions x number of client VMs to an existing deployment, and joins them to the deployment's domain.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Provide the following information:

+ Resource group name
+ VNet name
+ AD domain name
+ AD DC IP address
+ AD username and password

## Solution notes

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS3_v2.

___
Developed by the **MARVEL Skunkworks Lab**

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

Last update: _6/19/2019_

## Changelog

+ **6/19/2019**:  Initial commit
