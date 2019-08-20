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
+ Existing VNet name to which VMs will be connected
+ Vnet subnet name

## Solution notes

+ Depends on an existing VNet/subnet and properly configured access to an image in an existing Azure storage account.
+ Image must be stored as a **page blob**, and must be of **fixed** type.
+ Access to the VM depends on pre-existing user accounts in the image configuration.

## Known issues

___
Developed by the **MARVEL Skunkworks Lab**

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

Last update: _8/20/2019_

## Changelog

+ **8/20/2019**:  Initial commit.
