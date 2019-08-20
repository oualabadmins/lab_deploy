# Skunkworks Lab - X VM Base Configuration with Custom Client VM Image (v1.0)

* **IMPORTANT**: Only deploy this template into a subscription with no ExpressRoute circuit.

**Time to deploy**: 40+ minutes depending on deployment parameters

Last updated _7/19/2018_

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Ftlg-base-config_x-vm%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Ftlg-base-config_x-vm%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

The **X VM Base Configuration** template deploys a multi-VM environment based on the <a href="https://github.com/oualabadmins/lab_deploy/tree/master/tlg-base-config_x-vm">**TLG 3 VM Base Configuration**</a>, which represents a simplified intranet connected to the Internet.

The **X VM Base Configuration** provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.

## Usage

You can deploy this template in one of two ways:

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal
+ Execute the PowerShell script at https://raw.githubusercontent.com/oualabadmins/lab_deploy/master/tlg-base-config_x-vm/scripts/Deploy-TLG-X.ps1 on your local computer.

Test deployments using one of two configurations:
+ Deploy to the _MAXLAB R&D Sandbox_ subscription, and use the custom Windows 10 image at https://sandboxwusimages.blob.core.windows.net/vhds/Win10.vhd. Enter that value into the **clientVhdUri** field, make sure the value of **deployClientVm** is _Yes_, and then deploy to the _West US_ region, which is where the storage account containing the image resides.
+ Deploy to the _MAXLAB R&D EXT 1_ subscription, and use the custom Windows 10 image at https://tlgqscus01client.blob.core.windows.net/vhds/Win10.vhd. Enter that value into the **clientVhdUri** field, make sure the value of **deployClientVm** is _Yes_, and then deploy to the _Central US_ region, which is where the storage account containing the image resides.

### Client VM deployment notes

At this time, the template is configured to use a custom client disk image to conform to the requirements of publicly available templates. I am working on creating another lab-specific version of the template using the Windows 10 gallery image, which will allow deployment to any non-ExpressRoute subscription and any region.

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **ADDC VM**: Windows Server 2012 R2 or 2016 VM configured as a domain controller and DNS with static private IP address
+ **App Server VM(s)**: Windows Server 2012 R2 or 2016 VM(s) joined to the domain. IIS is installed, and C:\Files containing example.txt is shared as "Files".
+ **Client VM(s)**: Windows 10 client(s) joined to the domain
+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated. ADDC and App Server VMs in the deployment use managed disks, so no storage accounts are created for VHDs.
+ **NSG**: Network security group configured to allow inbound RDP on 3389
+ **Virtual network**: Virtual network for internal traffic, configured with custom DNS pointing to the ADDC's private IP address and tenant subnet 10.0.0.0/8 for a total of 16,777,214 available IP addresses.
+ **Network interfaces**: 1 NIC per VM
+ **Public IP addresses**: 1 static public IP per VM. Note that some subscriptions may have limits on the number of static IPs that can be deployed for a given region.
+ **JoinDomain**: Each member VM uses the **JsonADDomainExtension** extension to join the domain.
+ **BGInfo**: The **BGInfo** extension is applied to all VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all VMs with basic scheduled scan and exclusion settings.

## Solution notes

* The domain user *User1* is created in the domain and added to the Domain Admins group. User1's password is the one you provide in the *adminPassword* parameter.
* The *App server* and *Client* VM resources depend on the **ADDC** resource deployment to ensure that the AD domain exists prior to execution of the JoinDomain extensions. The asymmetric VM deployment adds a few minutes to the overall deployment time.
* The private IP address of the **ADDC** VM is always *10.0.0.10*. This IP is set as the DNS IP for the virtual network and all member NICs.
* The default VM size for all VMs in the deployment is Standard_D2_v2.
* Deployment outputs include public IP address and FQDN for each VM.

`Tags: TLG, Test Lab Guide, Base Configuration`
___
Developed by the **MARVEL Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")
