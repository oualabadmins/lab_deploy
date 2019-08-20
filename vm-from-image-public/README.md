# Skunkworks Lab - Deploy VMs From Image v0.1

**Time to deploy**: ~10 minutes

The **Deploy VMs From Image** template provisions a single VM from an existing image in a storage account.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fvm-from-image-public%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fvm-from-image-public%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

Provide the following information:

+ Name of the VM
+ VM size
+ Name of the storage account containing the image
+ The named path of the stored VM image, i.e. vhds/image.vhd
+ VNet name to which VMs will be connected
+ Vnet subnet name

## Solution notes

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS3_v2.

___
Developed by the **MARVEL Skunkworks Lab**

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

Last update: _8/20/2019_

## Changelog

+ **8/20/2019**:  Initial commit.
