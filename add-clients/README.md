# Skunkworks Lab - Add client VMs to existing deployment v0.4

**Time to deploy**: ~10 minutes

The **Add client VMs to existing deployment** template provisions _x_ number of client VMs to an existing deployment (either public or private), and joins them to the deployment's domain.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Provide the following information:

+ Resource group name of the existing deployment
+ VNet name to which VMs will be connected
+ AD domain name
+ OU for computer accounts, with container identifier (i.e. _CN=Computers_)
+ AD DC IP address
+ AD username and password
+ Number of client VMs to add
+ Starting number for client names (if there are existing clients, use the next unused increment)

## Solution notes

+ You cannot add computer accounts to the default _CN=Computers_ OU using the ADDomainExtension. Before deployment, check **AD Users and Computers** to see if a custom OU exists for computer account objects. If not, create one in the AD domain (for example, **OU=Machines**).

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS3_v2.

___
Developed by the **MARVEL Skunkworks Lab**

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

Last update: _6/19/2019_

## Changelog

+ **6/19/2019**:  Initial commit. Derived from oualabadmins\lab_deploy\M365-base-config_DirSync. Added parameters for vnetName, OU, clientStartNumber, dcIp.
