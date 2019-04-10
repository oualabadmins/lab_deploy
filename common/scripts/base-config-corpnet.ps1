param (
[string]$OfficeVersion,
[string]$role
)

<#
# base-config.ps1
#
	Default settings script for ARM templates.
	kelley 8/9/2016

	Revision history:
	9/28/2016 Updated for nested template testing
	10/5/2016 Added code to add redmond\oualabadmins to local admins if computer joined to Redmond
	10/27/2016 Added sections: disable IE ESC, disable server mgr, disable file warnings, configure Explorer, set power mgmt, set time zone to PST, set wusa to auto-update
	10/17/2018 Revised to run Office client installer using version from $OfficeVersion param, and remote PS to add new SH to RDS
	10/24/2018 Added code to run Office installer using passed param $OfficeVersion, RDS config if $role is RDS
	1/16/2019 Fixed issues with several sections, remmed out 'Enable RD firewall rules'
#>

##### ELEVATE IN x64 #####

$WID=[System.Security.Principal.WindowsIdentity]::GetCurrent();
$WIP=new-object System.Security.Principal.WindowsPrincipal($WID);
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator;
If ($WIP.IsInRole($adminRole)){
}
else {
	$newProcess = new-object System.Diagnostics.ProcessStartInfo 'PowerShell';
	$newProcess.Arguments = $myInvocation.MyCommand.Definition
	$newProcess.Verb = 'runas'
	[System.Diagnostics.Process]::Start($newProcess)
	exit
	}

# Execute elevated code

	# Add oualabadmins to local admins if joined to Redmond (not needed in OSSCPUB)
	$domain = (Get-WmiObject Win32_ComputerSystem).Domain
	if ($domain -eq "redmond.corp.microsoft.com") {
		Write-Host
		Write-Host "Adding " -NoNewline; Write-Host "redmond\oualabadmins " -f Cyan -NoNewline; Write-Host "to local admins..."
		$group = [ADSI]"WinNT://./Administrators,group" 
		$domain = "REDMOND"
		$group0 = "oualabadmins"
		$group.add("WinNT://$domain/$group0,Group")
		Write-Host "Done." -f Green
		}

	# Disable UserAccessControl
	Write-Host
	Write-Host "Configuring " -NoNewline; Write-Host "UAC" -f Cyan -NoNewline; Write-Host "..."
	Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
	Write-Host "Done." -f Green

	# Install .NET 3.5
	Add-WindowsFeature NET-Framework-Core

	# Disable IE ESC
	$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
	$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
	Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
	Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

	# Disable Server Manager at startup
	Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Server Manager\" -TaskName "ServerManager"
	
	# Set power management plan to High Performance
	Start-Process -FilePath "$env:SystemRoot\system32\powercfg.exe" -ArgumentList "/s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" -NoNewWindow
	
	# Disable warning on file open
	Push-Location
	Set-Location HKCU:
	Test-Path .\Software\Microsoft\Windows\CurrentVersion\Policies\Associations
	New-Item -Path .\Software\Microsoft\Windows\CurrentVersion\Policies -Name Associations
	Pop-Location
	New-ItemProperty -name LowRiskFileTypes -propertyType string HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations -value ".exe;.bat;.msi;.reg;.ps1;.vbs"

	# Configure Explorer (show file extensions, hidden items, replace cmd with PS in Start)
	$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
	Set-ItemProperty $key Hidden 1
	Set-ItemProperty $key HideFileExt 0
	Set-ItemProperty $key ShowSuperHidden 1
	Set-ItemProperty $key DontUserPowerShellOnWinx 0
	Stop-Process -processname explorer
	
	# Set WUSA to auto-install updates
	$wusa = (New-Object -ComObject "Microsoft.Update.AutoUpdate").Settings
	$wusa.NotificationLevel = 4
	$wusa.ScheduledInstallationDay = 0
	$wusa.IncludeRecommendedUpdates = $true
	$wusa.NonAdministratorsElevated = $true
	$wusa.FeaturedUpdatesEnabled = $true
	$wusa.save()

	# Set time zone to PST
	tzutil /s "Pacific Standard Time"

	# Create C:\Scripts
	New-Item -Path C:\Scripts -ItemType Directory -ErrorAction SilentlyContinue
	
# Role-specific config
if ($role -eq "RDS") {

    # Add RDS servers to local admins
    Write-Host
    Write-Host "Adding " -NoNewline; Write-Host "RDS computers " -f Cyan -NoNewline; Write-Host "to local admins..."
    $localGroup = [ADSI]"WinNT://./Administrators,group"
    $CBs = @("MAX-AZ-RDS-01$", "MAX-AZ-RDS-02$")
	foreach ($CB in $CBs) {
        $CB = [ADSI]"WinNT://OSSCPUB/$CB"
        $localGroup.add($CB.Path)
        }

	# Add local computer to AD RDS computers group (Authenticates to AD as osscpub\oualabadmin)
	Install-WindowsFeature RSAT-AD-PowerShell
	$userName = "osscpub\oualabadmin"
    $password = ConvertTo-SecureString "BorgFlatulentParlor!" -AsPlainText -force
	$user = New-Object Management.Automation.PSCredential("$UserName", $password)
    $hostname = $ENV:COMPUTERNAME
    Invoke-Command -ComputerName "ossua-dc1" -Credential $user -ScriptBlock `
	    {
        param(
        $user,$hostname
        )
		    $LMCN = "CN=$hostname,OU=Azure RDS Session Hosts,OU=Azure,DC=osscpub,DC=selfhost,DC=corp,DC=microsoft,DC=com"
		    $ADgroup = Get-ADGroup -Credential $user "CN=RDS Session Hosts - Office clients,CN=Users,DC=osscpub,DC=selfhost,DC=corp,DC=microsoft,DC=com" -Server "ossua-dc1.osscpub.selfhost.corp.microsoft.com"
            $ADgroup
		    Add-ADGroupMember $ADgroup -Members $LMCN -Credential $user -Server "ossua-dc1.osscpub.selfhost.corp.microsoft.com" 
	    } -argumentlist @($user, $password)
}

# Install Office client and Charles Proxy
if ($OfficeVersion -ne "none") {

	# Copy files to remote client
	$sharePath = "\\max-share.osscpub.selfhost.corp.microsoft.com\library"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\Configure Charles.lnk") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\InstallCharlesLocal.ps1") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\charles-proxy*.msi") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\charles.config") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\Charles.ini") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\ConfigureCharlesUser.cmd") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\ConfigureCharlesUser.ps1") "C:\Scripts"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\ConfigureCharlesUser.cmd") "C:\CharlesInstall"
	Copy-Item -Path ($sharePath + "\scripts\rds\Charles\ConfigureCharlesUser.ps1") "C:\CharlesInstall"
	Copy-Item -Path ($sharePath + "\scripts\rds\Office\Install Office Clients.lnk") "C:\Scripts"

# Unblock and set files to read/write
Unblock-File -Path C:\Scripts\*.*
get-childitem C:\Scripts\*.* -Recurse -File | % { $_.IsReadOnly=$false }

# Install Charles
& C:\Scripts\InstallCharlesLocal.ps1 | Out-Null

# Install Office client
& ($sharePath + "\scripts\RDS\Office\InstallOfficeClients.ps1") $OfficeVersion | Out-Null

# Copy Office and Charles setup links to public desktop
Copy-Item "C:\Scripts\Install Office Clients.lnk" "C:\Users\Public\Desktop"
Copy-Item "C:\Scripts\Configure Charles.lnk" "C:\Users\Public\Desktop"
}

# END #
Write-Host "Script completed." -f Green
exit