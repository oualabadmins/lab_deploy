# Oualabadmins Lab_Deploy

This is the public repo for MAX Skunkworks lab build deployments.

+ **max-base-config_x-vm**: MAX Skunkworks Lab - X VM Base Configuration with Gallery Client VM Image

    **Lab admins** - Use this template for multi-VM farms with a custom AD domain in PUBLIC (non-corpnet connected) subscriptions.

    The X VM Base Configuration provisions a test environment in a private virtual network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.

+ **max-base-config_x-vm_corpnet**: MAX Skunkworks Lab - X VM Base Configuration for Corpnet

    **Lab admins** - Use this template for multi-VM farms with a custom AD domain in CORPNET-connected subscriptions.

    The X VM Base Configuration provisions a test environment on the corpnet network consisting of a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10.

+ **tlg-base-config_3-vm**: TLG (Test Lab Guide) - 3 VM Base Configuration

    The TLG (Test Lab Guide) 3 VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, an application server running Windows Server 2012 R2 or 2016, and optionally a client VM running Windows 10.

+ **tlg-base-config_x-vm**: MAX Skunkworks Lab - X VM Base Configuration with Custom Client VM Image

    The X VM Base Configuration provisions a Windows Server 2012 R2 or 2016 Active Directory domain controller using the specified domain name, one or more application servers running Windows Server 2012 R2 or 2016, and optionally one or more client VMs running Windows 10. All member VMs are joined to the domain.

+ **ubuntu-mate-desktop-vscode**: MAX Skunkworks Lab - Ubuntu Linux Workstation
