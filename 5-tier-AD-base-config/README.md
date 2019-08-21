# &#x1f984; Skunkworks Lab - 5-Tier AD Base Configuration - Public v1.0

**Time to deploy**: 20-40 minutes, depending on complexity

&#x1f984; This is the **Golden Unicorn Template** for public lab deployments! Use this template for multi-VM farms with a custom AD domain in PUBLIC (non-corpnet connected) subscriptions. &#x1f984;

The **5-Tier AD Base Configuration** template provisions a flexible lab environment with a custom AD domain in a public subscription. You can choose to deploy the following five tiers (only the _AD DC_ tier is required):

+ AD DC
+ SQL Server
+ Application server
+ SharePoint Server
+ Windows 10 client

All server VMs can be deployed with Windows Server 2012 R2, 2016 or 2019, and all VMs are automatically joined to the custom AD domain.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2F5-tier-AD-base-config%2Fazuredeploy.json" target="_blank">
<img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Foualabadmins%2Flab_deploy%2Fmaster%2F5-tier-AD-base-config%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>

## Usage

This template is intended for deployment in a **public Azure subscription**.

Click the **Deploy to Azure** button and complete the deployment form. Select a public subscription such as:

+ MAXLAB R&D Sandbox
+ MAXLAB R&D EXT 1
+ MAXLAB R&D EXT 2

## Solution notes

+ Machine tier deployment notes:
  + **AD DC**: Windows Server VM configured as a domain controller and DNS
    + Users created: _User1_ (domain admin account), _sqlsvc_ (SQL service), and _spfarmsvc_ (SharePoint Farm service). These accounts all use the password you specify in the **adminPassword** field.
  + **SQL Server**: 0-1 Windows Server VM(s) with SQL Server **2014 SP3**, **2016 SP2** or **2017**
    + The name of the SQL Server VM is always **SQL._\<domain>_**.
    + You can only deploy a single SQL Server VM. SQL AlwaysOn is not available in this template.
    + SQL is configured with the default instance name SQL\\_MSSQLSERVER_ with TCP enabled on port **1433**.
    + The user account you specified in the deployment is used to create a local admin account on the SQL Server VM that belongs to the _sysadmin_ role. Other domain accounts are added as SQL logins in the sysadmin role by DSC: _\<domain>\domain admin account_, _\<domain>\sqlsvc_ and _\<domain>\spfarmsvc_.
  + **SharePoint Servers**: 0-_X_ Windows Server VM(s) with SharePoint Server **2013**, **2016** or **2019**
    + SharePoint is installed, but not configured. To provision SharePoint, either run the Configuration Wizard or use [AutoSPInstaller](https://autospinstaller.com).
      + Before deployment, check to make sure you choose a SQL Server version that is supported by the desired SharePoint Server version.
      + When configuring SharePoint, specify the database server SQL.<yourdomain>, and use the database access account _\<domain>\sqlsvc_ using the same password you specified for the admin account.
      + Use the service account _\<domain>\spsvc_ for the SharePoint Farm service.
    + You can navigate to SharePoint sites in your deployment from other VMs in the same deployment. If you want to navigate to your deployment's SharePoint sites from your work computer, you must add the SharePoint server's FQDN (i.e. _SP1.\<domain>.com_) and IP address to your work computer's HOSTS file (C:\Windows\system32\drivers\etc\hosts).
  + **App servers**: 0-_X_ Windows Server VM(s) for custom purposes
    + IIS is installed on each app server, and C:\Files containing the blank document _example.txt_ is shared as "Files".
    + Azure AD Connect (dynamically downloads the latest version) is installed on the first app server only. **APP1** will always be your DirSync server.
  + **Windows 10 clients**: 0-_X_ Windows 10 client VM(s). No special configuration other than joining to the local AD domain.

+ **General notes**:
  + During deployment, if the _Environment Name_ value is not unique within the DevTest Lab instance, Azure will append a series of numbers to the VM names in your deployment. These numbers are only appended to the VM names as shown in Azure, _not_ the machine hostnames.
  + The domain user *User1* is created in the domain and added to the Domain Admins group. User1's password is set to the value you provide in the _Admin Password_ parameter.
  + The other machine tier's VM resources depend on the **ADDC** resource deployment to ensure that the AD domain exists prior to execution of the JoinDomain extensions. The asymmetric VM deployment adds a few minutes to the overall deployment time.
  + Remember, when you RDP to your VM, you will log in with the credentials **_domain_\adminusername** where _domain_ is the custom domain of your environment.

## Known issues

+ The client VM deployment may take longer than expected, and then appear to fail. The client VMs and extensions may or may not deploy successfully. This is due to an ongoing Azure client deployment bug, and only happens when the client VM size is smaller than DS3_v2.

___
Developed by the **MARVEL Skunkworks Lab**

![alt text](../common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Author: Kelley Vice (kvice@microsoft.com)  
https://github.com/maxskunkworks

Last update: _8/21/2019_

## Changelog

+ **7/19/2019**: Original commit, derived from https://github.com/oualabadmins/lab_deploy/tree/master/5-tier-AD-base-config.
+ **7/23/2019**: Updated DSC resources and reordered dependencies in azuredeploy.json. Deploys with no errors.
+ **8/21/2019**: Added a dependency to the ADDC resource to wait for the storage account.
