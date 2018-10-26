# MAX Skunkworks Lab - ArcSight SIEM Base Configuration - Public (v0.4)

**IMPORTANT**: Only deploy this template into a PUBLIC subscription.

**Choose one of these MAX Skunkworks Lab subscriptions:**

| Subscription
| :-------------------
| MAXLAB R&D Sandbox
| MAXLAB R&D EXT 1
| MAXLAB R&D EXT 2

**Time to deploy**: 25+ minutes

The **ArcSight SIEM Base Configuration - Public** template provisions a test environment on a public virtual network consisting of a CentOS 7.3 Linux VM with ArcSight ESM installed, and one or more Windows 10 VMs.

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

>**NOTE:** As of 10/3/2018, the template successfully deploys all VMs with xrdp running on the CentOS VMs. No ArcSight installation or config is being done yet.

The following resources are deployed as part of the solution:

### VMs

+ **ArcSight CentOS Server VM(s)**: CentOS 7.3 with ArcSight ESM 7.1. 30GB system disk, 1TB data disk, all managed. Arcsight installation script is in progress, not yet working.
+ **Client VM(s)**: Windows 10 client(s) with ArcSight software. Managed 127GB system disk.

### Storage

+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated.

### Network

+ **Virtual network**: 1 Vnet with two subnets, frontend and backend. Frontend subnet is 172.16.0.0/25, backend is 172.16.0.128/25.
+ **Network security group**: The NSG permits ports 22 and 3389 to frontend NICs.
+ **Network interfaces**: 2 NICs per VM with dynamic private IP addresses. Frontend NICs also have a public IP.
+ **Public IPs**: 1 public IP per frontend NIC for both SIEM and CLIENT VMs.

### Extensions

+ **siemconfig**: The bash script /scripts/initialconfig.sh is executed on the SIEM VM with the Linux custom script extension. This script creates a cron job to run /scripts/siemconfig.sh after reboot (NOT YET IMPLEMENTED). Staggering the scripts this way avoids CSE extension timeouts.
+ **BGInfo**: The **BGInfo** extension is applied to all VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all VMs with basic scheduled scan and exclusion settings.

## Solution notes

+ **Minimum requirements**: The SIEM server should be a DS4_V2 at minimum. Minimum server requirements:
    + 8 cores
    + 36GB RAM
    + 250GB disk capacity
+ Current template successfully deploys SIEM VM with xrdp and Mate Desktop, and mounts 1TB data disk at _/arcsight_. No ArcSight deployment will be done until we get install bits and license.
+ Remember, when you RDP to your VM, you will use the admin username and password you specified at deploy time, _not_ your corpnet credentials.

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS4_v2.

`Tags: SIEM, ArcSight, ESM`
___
Developed by the **MAX Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _9/19/2018_

## Changelog

+ **9/4/2018**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/max-base-config_x-vm_corpnet.
+ **9/12/2018**: Deployment of Azure resources working, ./scripts/siemconfig.sh is being developed. XRDP with Mate desktop is deployed automatically.
+ **9/19/2018**: Split script: initialconfig.sh installs xrdp, MATE, and configures user desktop. Also mounts the 1TB data disk at /arcsight. siemconfig.sh will run after, and will provision ArcSight.