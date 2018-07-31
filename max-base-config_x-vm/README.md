# MAX Skunkworks Lab - X VM Base Configuration with Gallery Client VM Image (v1.2)

**IMPORTANT**: Only deploy this template into a subscription with no ExpressRoute circuit. These currently include:

+ MAXLAB R&D Sandbox
+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2

**Time to deploy**: 40+ minutes

The **X VM Base Configuration** provisions a test environment in a private virtual network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_x-vm%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_x-vm%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

This version of the template uses the Windows 10 gallery image, and can be deployed to any non-ExpressRoute subscription and region.

You can deploy this template in one of two ways:

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal
+ Execute the PowerShell script at https://raw.githubusercontent.com/oualabadmins/lab_deploy/master/max-base-config_x-vm/scripts/Deploy-TLG-X.ps1 on your local computer. Note that you'll need the AzureRM PowerShell module to do this. You can install it by running the following from an elevated PowerShell console:

    ```PowerShell
    Install-Module AzureRM -Force
    ```

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **AD DC VM**: Windows Server 2012 R2 or 2016 VM configured as a domain controller and DNS with static private IP address
+ **App Server VM(s)**: Windows Server 2012 R2 or 2016 VM(s) joined to the domain. IIS is installed, and C:\Files containing example.txt is shared as "Files".
+ **Client VM(s)**: Windows 10 client(s) joined to the domain
+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated. ADDC and App Server VMs in the deployment use managed disks, so no storage accounts are created for VHDs.
+ **NSG**: Network security group configured to allow inbound RDP on 3389
+ **Virtual network**: Virtual network for internal traffic, configured with custom DNS pointing to the ADDC's private IP address and tenant subnet.
+ **Network interfaces**: 1 NIC per VM
+ **Public IP addresses**: 1 static public IP per VM. Note that some subscriptions may have limits on the number of static IPs that can be deployed for a given region.
+ **JoinDomain**: Each member VM uses the **JsonADDomainExtension** extension to join the domain.
+ **BGInfo**: The **BGInfo** extension is applied to all VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all VMs with basic scheduled scan and exclusion settings.

## Solution notes

* The domain user *User1* is created in the domain and added to the Domain Admins group. User1's password is the one you provide in the *adminPassword* parameter.
* The *App server* and *Client* VM resources depend on the **ADDC** resource deployment to ensure that the AD domain exists prior to execution of the JoinDomain extensions. The asymmetric VM deployment adds a few minutes to the overall deployment time.
* You can specify the tenant subnet in the *subnetCIDR* parameter. For most deployments, the default subnet 10.0.0.0/24 will work fine.
* The private IP address of the DC VM is always *x.x.x.10* in the specified subnet. This IP is set as the primary DNS IP for the virtual network's tenant subnet to allow member VMs to resolve the local AD domain.
* Remember, when you RDP to your VM, you will use **domain\adminusername** for the custom domain of your environment, _not_ your corpnet credentials.

## Known issues

* The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS4_v2.

`Tags: TLG, Test Lab Guide, Base Configuration`
___
Developed by the **MAX Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _7/19/2018_

## Changelog

+ **7/17/2018**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/tlg-base-config_x-vm. Configured to use the Win10 gallery image instead of the original custom image requirement.
+ **7/19/2018**: Updated to allow choice of tenant subnet CIDR address, and added separate parameters for server and client VM size.
+ **7/31/2018**: Added :443 inbound to NSG security rules.