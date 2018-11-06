# MAX Skunkworks Lab - ArcSight SIEM Base Configuration - Public (v1.0)

**IMPORTANT**: Only deploy this template into a PUBLIC subscription.

**Choose one of these MAX Skunkworks Lab subscriptions/regions:**

| Subscription | Region
| :------------------- | :-------------------
| MAXLAB R&D Sandbox | West US 2
| MAXLAB R&D EXT 1 | West US 2 <br> East US
| MAXLAB R&D EXT 2 | Central US <br> East US

**Time to deploy**: 25+ minutes

The **ArcSight SIEM Base Configuration - Public** template provisions a test environment on a public virtual network consisting of a CentOS 7.4 Linux VM with ArcSight ESM installed, and one or more Windows 10 VMs running the ArcSight console and the Office 365 Connector.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_arcsight_public%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2Fmax-base-config_arcsight_public%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Prerequisites

Prior to deployment of ArcSight software, you must download the following binaries from the MicroFocus website and acquire licenses. You can inquire about 180-day trial licenses by contacting Micro Focus at software.partner@microfocus.com.

| Package | Binaries | Documentation
| :------------------- | :------------------- | :-------------------
| Micro Focus Security ArcSight Enterprise Security Manager Software 7.0 (TH001H) | ArcSightESMSuite-7.0.0.2234.1.tar <br> ArcSight-7.0.0.2436.1-Console-Win.exe | ESM_InstallGuide_7.0P1.pdf <br> ESM_ArcSightConsole_UserGuide_7.0P1.pdf |
| Micro Focus Security ArcSight SmartConnectors Framework 7.10.0 (TH016AAE) | ArcSight-7.10.0.8114.0-Connector-Win64.exe | [MicrosoftOffice365Config.pdf](https://community.softwaregrp.com/t5/ArcSight-Connectors/SmartConnector-for-Microsoft-Office-365/ta-p/1583309?attachment-id=68456) |

You must also provision an Office 365 E5 tenant and configure an AAD Enterprise App for connector authentication.

## Usage

To deploy the template:

+ Click the "Deploy to Azure" button to open the deployment UI in the Azure portal
+ Log into SIEM VM as **admin** user and manually run /scripts/prep-arcsight.sh | reboot
+ Log into SIEM VM as **arcsight** user and manually run /scripts/install-arcsight.sh
+ Log into SIEM VM as **admin** user and manually run /scripts/start-arcsight.sh
+ If you haven't done so already, provision an Office 365 E5 tenant and follow the procedures in **MicrosoftOffice365Config.pdf** to configure an AAD Enterprise App to enable connector authentication. See the **Known Issues** section of this README for important information.
+ Log into CLIENT VM as **admin** user and install ArcSight console and connectors as needed

## Solution overview and deployed resources

>**NOTE:** ArcSight ESM installation must be done manually by manually running the scripts listed in _Usage_ on each SIEM server you wish to configure with ESM.

The following resources are deployed as part of the solution:

### VMs

+ **ArcSight CentOS Server VM(s)**: CentOS 7.4 with ArcSight ESM 7.1. 1TB system disk, 1TB data disk, all managed.
+ **Client VM(s)**: Windows 10 client(s) with ArcSight software. Managed 127GB system disk.

### Storage

+ **Storage account**: Diagnostics storage account, and client VM storage account if indicated.

### Network

+ **Virtual network**: 1 Vnet with two subnets, frontend and backend. Frontend subnet is 172.16.0.0/25, backend is 172.16.0.128/25.
+ **Network security group**: The NSG permits ports 22 and 3389 to frontend NICs.
+ **Network interfaces**: 2 NICs per VM with dynamic private IP addresses. Frontend NICs also have a public IP.
+ **Public IPs**: 1 public IP per frontend NIC for both SIEM and CLIENT VMs.

### Extensions

+ **initialconfig**: The bash script /scripts/initialconfig.sh is executed on the SIEM VM(s) with the Linux custom script extension. Additional scripts must be executed manually.
+ **BGInfo**: The **BGInfo** extension is applied to all Windows VMs.
+ **Antimalware**: The **iaaSAntimalware** extension is applied to all Windows VMs with basic scheduled scan and exclusion settings.

## Solution notes

+ **Minimum requirements**: The SIEM server should be a DS4_V2 at minimum. Minimum server requirements:
  + 8 cores
  + 36GB RAM
  + 250GB disk capacity
+ Current template successfully deploys SIEM VM with xrdp and Mate Desktop, and mounts 1TB data disk at _/arcsight_.
+ Remember, when you RDP to your VM, you will use the admin username and password you specified at deploy time, _not_ your corpnet credentials.

## Known issues

+ After updating the template to deploy CentOS 7.4, some lines of the initialconfig.sh script appear to fail in the SIEM deployment. However, everything works as expected.
+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS4_v2.
+ When configuring the AAD App for the Office 365 Connector, you must add READ permissions for all Office Management APIs, both Application and Delegated permissions, contrary to the guidance in **Step 3** of the _Specifying Permissions in Microsoft Management Activity API_ section of the SmartConnector for Microsoft Office 365 Configuration Guide.

`Tags: SIEM, ArcSight, ESM`
___
Developed by the **MAX Skunkworks Lab**  
Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

![alt text](images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _11/6/2018_

## Changelog

+ **9/4/2018**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/max-base-config_x-vm_corpnet.
+ **9/12/2018**: Deployment of Azure resources working, ./scripts/siemconfig.sh is being developed. XRDP with Mate desktop is deployed automatically.
+ **9/19/2018**: Split script: initialconfig.sh installs xrdp, MATE, and configures user desktop. Also mounts the 1TB data disk at /arcsight. siemconfig.sh will run after, and will provision ArcSight.
+ **11/6/2018**: Merged into master branch. Split scripts by execution order and login user. Added binary info to _Usage_ section.