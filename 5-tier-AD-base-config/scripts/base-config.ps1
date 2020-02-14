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
	5/22/2019 Streamlined for custom domains
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

# END #
Write-Host "Script completed." -f Green
exit