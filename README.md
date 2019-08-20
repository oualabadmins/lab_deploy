# Skunkworks Lab Deploy Repo

This is the public repo for MARVEL Skunkworks Lab deployments. All code in this repo is public (read-only to non-contributors), so do not commit code that contains usernames, passwords or any MBI-HBI information. All templates in the master branch of this repo have been tested and should deploy successfully, subject to limitations and known issues described in each template's README.

Templates in the repo but not listed below may not function properly!

## Templates

| Template                     | Name                                                    | Description
| :-------------------         | :-------------------                                    | :-------------------
| &#x1f984; <br> [**5-tier-AD-base-config**](5-tier-AD-base-config/README.md)         | 5-Tier AD Base Configuration - Public                  | **Lab admins** - This is the **Golden Unicorn Template** for public lab deployments! Use this template for multi-VM farms with a custom AD domain in PUBLIC (non-corpnet connected) subscriptions. <br> The 5-Tier AD Base Configuration template provisions a flexible lab environment with a custom AD domain in a public subscription.  You can choose to deploy the following five tiers: AD DC, SQL Server, Application server, SharePoint Server, and Windows 10 client.
| [**add-clients**](add-clients/README.md)         | Add client VMs to existing deployment                         | **Lab admins** - Use this template to add Windows 10 client VMs to an existing environment. <br> The Add client VMs to existing deployment template provisions x number of client VMs to an existing deployment, and joins them to the deployment's domain.
| [**max-base-config_x-vm**](max-base-config_x-vm/README.md)         | X VM Base Configuration - Public                        | **Lab admins** - Use this template for multi-VM farms with a custom AD domain in PUBLIC (non-corpnet connected) subscriptions. <br> The X VM Base Configuration provisions a test environment in a private virtual network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.
| [**max-base-config_x-vm_corpnet**](max-base-config_x-vm_corpnet/README.md) | X VM Base Configuration - Corpnet                       | **Lab admins** - Use this template for multi-VM farms with a custom AD domain in CORPNET-connected subscriptions. <br> The X VM Base Configuration provisions a test environment on the corpnet network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.
| [**max-sql-secure**](max-sql-secure/README.md)              | SQL Azure Secure Configuration - Public                      | **Lab admins** - Use this template for deployment of a secure SQL server on public subscriptions. <br> The SQL Azure Secure Configuration provisions a SQL Azure instance with two private virtual networks with a service endpoint.
| [**nsg-lockdown**](nsg-lockdown/README.md)              | NSG Lockdown - Public                      | **Lab admins** - Use this template to lock down existing NSGs to only permit traffic from corpnet subnets and optional other Internet IPs, such as home networks. <br> The NSG Lockdown template adds security rules to an existing NSG to permit RDP, SSH and PowerShell Remoting connections ONLY from corpnet edge subnets and other IPs or subnets specified in the template.
| [**max-dtl_corpnet**](max-dtl_corpnet/README.md)              | MAXLAB DTL (DevTest Lab) - Corpnet                      | **Lab admins** - Use this template for deployment of private corpnet-connected DevTest Lab instances. <br> The MAXLAB DTL (DevTest Lab) - Corpnet provisions a complete DevTest lab on a corpnet-connected ER circuit with formulas and a connection to the GitHub DTL artifact and ARM template repos.
| [**tlg-base-config_3-vm**](tlg-base-config_3-vm/README.md)         | TLG (Test Lab Guide) - 3 VM Base Configuration          | The TLG (Test Lab Guide) 3 VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, an application server running Windows Server 2012 R2 or 2016, and optionally a client VM running Windows 10.
| [**tlg-base-config_x-vm**](tlg-base-config_x-vm/README.md)         | X VM Base Configuration with Custom Client VM Image     | The X VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.
| [**max-base-config_arcsight_public**](max-base-config_arcsight_public/README.md) | ArcSight SIEM Base Configuration - Public | The ArcSight SIEM Base Configuration - Public template provisions a test environment on a public virtual network consisting of a CentOS 7.4 Linux VM with ArcSight ESM 7.0 installed, and one or more Windows 10 VMs running the ArcSight console and the Office 365 Connector.

___
Developed by the **MARVEL Skunkworks Lab**
https://github.com/maxskunkworks

![alt text](https://github.com/oualabadmins/lab_deploy/blob/master/common/images/maxskunkworkslogo-small.jpg "MARVEL Skunkworks")

Last update: _7/22/2019_
