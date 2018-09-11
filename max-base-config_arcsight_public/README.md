# MAX Skunkworks Lab - ArcSight SIEM Base Configuration - Public (v1.0)

**IMPORTANT**: Only deploy this template into a PUBLIC subscription.

**Choose one of these subscriptions:**

| Subscription
| :-------------------
| MAXLAB R&D Sandbox
| MAXLAB R&D EXT 1
| MAXLAB R&D EXT 2

**Time to deploy**: 40+ minutes

The **ArcSight SIEM Base Configuration - Public** template provisions a test environment on a public virtual network consisting of a CentOS Linux VM with ArcSight SIEM installed, and one or more Windows 10 VMs.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fbase-config-arcsight-siem%2Fmax-base-config_arcsight_public%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fbase-config-arcsight-siem%2Fmax-base-config_arcsight_public%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

You can deploy this template in one of two ways:

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal
+ Execute the PowerShell script at https://raw.githubusercontent.com/oualabadmins/lab_deploy/master/max-base-config_arcsight_public/scripts/Deploy-Arcsight.ps1 on your local computer. Note that you'll need the AzureRM PowerShell module to do this. You can install it by running the following from an elevated PowerShell console:

    ```PowerShell
    Install-Module AzureRM -Force
    ```

## Solution overview and deployed resources

The following resources are deployed as part of the solution:

+ **ArcSight CentOS Server VM**: CentOS VM with ArcSight SIEM.
+ **Client VM(s)**: Windows 10 client(s) joined to the domain.
+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated. ADDC and App Server VMs in the deployment use managed disks, so no storage accounts are created for VHDs.
+ **Virtual network**: 1 Vnet with two subnets, frontend and backend. Frontend subnet is 172.16.0.0/25, backend is 172.16.0.128/25.
+ **Network security group**: The NSG permits ports 22 and 3389 to frontend NICs.
+ **Network interfaces**: 2 NICs per VM with dynamic private IP addresses. Frontend NICs also have a public IP.
+ **Public IPs**: 1 public IP per frontend NIC for both SIEM and CLIENT VMs.
+ **BGInfo**: The **BGInfo** extension is applied to all VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all VMs with basic scheduled scan and exclusion settings.

## Solution notes

+ Remember, when you RDP to your VM, you will use **domain\adminusername** for the custom domain of your environment, _not_ your corpnet credentials.

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS4_v2.

`Tags: SIEM, ArcSight, Base Configuration`
___
Developed by the **MAX Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _9/4/2018_

## Changelog

+ **9/4/2018**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/max-base-config_x-vm_corpnet.