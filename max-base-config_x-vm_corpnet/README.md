# Skunkworks Lab - X VM Base Configuration - Corpnet (v1.1)

**IMPORTANT**: Only deploy this template into a subscription with an existing ExpressRoute circuit, and to a region with an ER circuit. The template will automatically choose the correct ER virtual network based on subscription and region.

**Choose one of these subscription/region combinations:**

| Subscription             | Region(s)
| :-------------------     | :-------------------
| MAXLAB R&D Primary       | West US
| MAXLAB R&D Self Service  | South Central US <br> West Central US
| MAXLAB R&D INT 1         | West US 2 <br> West Central US
| MAXLAB R&D INT 2         | West US 2

**Time to deploy**: 40+ minutes

The **X VM Base Configuration - Corpnet** provisions a test environment on an existing corpnet-connected ER circuit consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_x-vm_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_x-vm_corpnet%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

You can deploy this template in one of two ways:

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal
+ Execute the PowerShell script at https://raw.githubusercontent.com/oualabadmins/lab_deploy/master/max-base-config_x-vm_corpnet/scripts/Deploy-TLG-X.ps1 on your local computer. Note that you'll need the AzureRM PowerShell module to do this. You can install it by running the following from an elevated PowerShell console:

    ```PowerShell
    Install-Module AzureRM -Force
    ```

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **AD DC VM**: Windows Server 2012 R2 or 2016 VM configured as a domain controller and DNS.
+ **App Server VM(s)**: Windows Server 2012 R2 or 2016 VM(s) joined to the domain. IIS is installed, and C:\Files containing example.txt is shared as "Files".
+ **Client VM(s)**: Windows 10 client(s) joined to the domain.
+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated. ADDC and App Server VMs in the deployment use managed disks, so no storage accounts are created for VHDs.
+ **Network interfaces**: 1 NIC per VM with dynamic private IP address.
+ **JoinDomain**: Each member VM uses the **JsonADDomainExtension** extension to join the domain.
+ **BGInfo**: The **BGInfo** extension is applied to all VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all VMs with basic scheduled scan and exclusion settings.

## Solution notes

* The domain user *User1* is created in the domain and added to the Domain Admins group. User1's password is the one you provide in the *adminPassword* parameter.
* The *App server* and *Client* VM resources depend on the **ADDC** resource deployment to ensure that the AD domain exists prior to execution of the JoinDomain extensions. The asymmetric VM deployment adds a few minutes to the overall deployment time.
* Remember, when you RDP to your VM, you will use **domain\adminusername** for the custom domain of your environment, _not_ your corpnet credentials.

## Known issues

* The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS4_v2.

`Tags: TLG, Test Lab Guide, Base Configuration`
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _8/9/2018_

## Changelog

+ **8/8/2018**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/max-base-config_x-vm.
+ **8/9/2018**: Updates to output from nic.json to return DC IP value back to the main template for passing to linked app and client templates. This enables adding the DC IP to DNS settings on member VMs. Removed NSG to avoid inadvertently applying security rules to existing common virtual networks.
+ **1/16/2019**: Updated Win10 SKU to rs3-pro-test to match availability.
+ **1/23/2019**: Updated Win10 SKU to RS3-Pro - the other sku doesn't exist.