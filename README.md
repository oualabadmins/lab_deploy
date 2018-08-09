# Oualabadmins Lab Deploy Repo

This is the public repo for MAX Skunkworks lab build deployments. All code in this repo is public (read-only to non-contributors), so do not commit code that contains usernames, passwords or any MBI-HBI information. All templates in the master branch of this repo have been tested and should deploy successfully, subject to limitations and known issues described in each template's README.

## Templates

| Template                     | Name                                                    | Description
| :-------------------         | :-------------------                                    | :-------------------
| max-base-config_x-vm         | X VM Base Configuration - Public                        | **Lab admins** - Use this template for multi-VM farms with a custom AD domain in PUBLIC (non-corpnet connected) subscriptions. <br> The X VM Base Configuration provisions a test environment in a private virtual network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.
| max-base-config_x-vm_corpnet | X VM Base Configuration - Corpnet                       | **Lab admins** - Use this template for multi-VM farms with a custom AD domain in CORPNET-connected subscriptions. <br> The X VM Base Configuration provisions a test environment on the corpnet network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.
| tlg-base-config_3-vm         | TLG (Test Lab Guide) - 3 VM Base Configuration          | The TLG (Test Lab Guide) 3 VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, an application server running Windows Server 2012 R2 or 2016, and optionally a client VM running Windows 10.
| tlg-base-config_x-vm         | X VM Base Configuration with Custom Client VM Image     | The X VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.

___
Developed by the **MAX Skunkworks Lab**
https://github.com/maxskunkworks

![alt text](https://github.com/oualabadmins/lab_deploy/blob/master/common/images/maxskunkworkslogo-small.jpg "MAX Skunkworks")

Last update: _8/9/2018_