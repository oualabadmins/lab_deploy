# MAX Skunkworks Lab - NSG Lockdown - Public (v0.1)

**IMPORTANT**: Only deploy this template into an external-facing subscription with no ExpressRoute circuit. These currently include:

+ MAXLAB R&D Sandbox
+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2

**Time to deploy**: ~1 minute

The **NSG Lockdown** template adds security rules to an existing NSG to permit RDP, SSH and PowerShell Remoting connections from corpnet subnets and any other IPs or subnets specified in the template.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fnsg-lockdown%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fnsg-lockdown%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **NSG security rules**: RDP (port 3389), SSH (port 22) and PowerShell Remoting (port 5985).

## Solution notes

Locks down RDP, SSH and PoSH to the following corpnet subnets:

131.107.0.0/16, 167.220.0.0/23, 167.220.100.0/22, 167.220.104.0/23, 167.220.56.0/21, 167.220.98.0/23

You can specify additional IPs and subnets with the _Other IPs_ parameter. Any of the following formats will work, and should look like the following:

+ ["192.168.0.54"]
+ ["192.168.0.54,192.168.0.55"]
+ ["192.168.0.0/24"]

## Known issues
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _7/18/2019_

## Changelog

+ **7/18/2019**: Original commit
