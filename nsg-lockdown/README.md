# Skunkworks Lab - NSG Lockdown - Public (v1.0)

**IMPORTANT**: Only deploy this template into an external-facing subscription with no ExpressRoute circuit. These currently include:

+ MAXLAB R&D Sandbox
+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2

**Time to deploy**: ~1 minute

The **NSG Lockdown** template adds security rules to an existing NSG to permit RDP, SSH and PowerShell Remoting connections **ONLY** from corpnet edge subnets and other IPs or subnets specified in the template.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fnsg-lockdown%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fnsg-lockdown%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal.
+ You will need the name of the target NSG before deployment.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **NSG security rules**: RDP (port 3389), SSH (port 22) and PowerShell Remoting (port 5985-5986).

## Solution notes

Locks down RDP, SSH and PoSH to the following corpnet subnets:

131.107.0.0/16, 167.220.0.0/23, 167.220.100.0/22, 167.220.104.0/23, 167.220.56.0/21, 167.220.98.0/23

You can specify additional IPs and subnets with the _Other IPs_ parameter. Any of the following formats will work, and should look like the following:

+ ["192.168.0.54"]
+ ["192.168.0.54,192.168.0.55"]
+ ["192.168.0.0/24"]

## Known issues

+ Existing rules for ports covered by this template are not removed automatically, so ports can still be open unless original rules are removed manually.

___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _7/19/2019_

## Changelog

+ **7/18/2019**: Original commit
+ **7/19/2019**: Updated with standard rule names and ports, tested completely.
