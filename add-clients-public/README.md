# Skunkworks Lab - Add client VMs to existing deployment (Public) v1.1

**Time to deploy**: ~10 minutes

The **Add client VMs to existing deployment** template provisions _x_ number of client VMs to an existing deployment in a public subscription, and joins them to the deployment's domain. You can choose Windows 7, 8.1 or 10.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients-public%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fadd-clients-public%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Only deploy this template in a corpnet-connected subscription such as:

+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2
+ MAXLAB R&D Sandbox

Provide the following information:

+ Resource group name of the existing deployment
+ VNet name to which VMs will be connected
+ AD domain name
+ OU for computer accounts, with container identifier (i.e. _CN=Computers_)
+ AD username and password for joining the domain. This account will also be added as the local administrator account on the VMs.
+ AD DC IP address
+ Client name prefix (the base name for the client VMs (i.e. CLIENT, which will result in VMs with names like CLIENT1, CLIENT2 etc.)
+ Client OS (Windows 7, 8.1, or 10)
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

Last update: _9/3/2019_

## Changelog

+ **6/19/2019**: Initial commit. Derived from oualabadmins\lab_deploy\M365-base-config_DirSync. Added parameters for vnetName, OU, clientStartNumber, dcIp.
+ **8/28/2019**: Added code to permit OS choice.
+ **9/3/2019**: Added param for client name prefix.
+ **9/3/2019**: Revised for use in public subscriptions (added public IP).
