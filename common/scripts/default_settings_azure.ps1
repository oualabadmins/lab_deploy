############################################
# Basic Settings Automation for Azure VMs
# MAX Lab
# kvice 7/31/2018
# 
# Rev 1
# 
############################################

# Start WinRM
if (-not (Get-service winrm)){
  net start Winrm
}
Enable-PSRemoting –force
Winrm quickconfig

# Set execution policy
Set-Executionpolicy unrestricted –force

# Disable IE ESC
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

# Disable UAC
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000

# Disable Server Manager at startup
Disable-ScheduledTask -TaskPath ‘\Microsoft\Windows\Server Manager\’ -TaskName ‘ServerManager’

# Set power management plan to High Performance
Start-Process -FilePath "$env:SystemRoot\system32\powercfg.exe" -ArgumentList "/s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" -NoNewWindow

# Disable warning on file open
Push-Location
Set-Location HKCU:
Test-Path .\Software\Microsoft\Windows\CurrentVersion\Policies\Associations
New-Item -Path .\Software\Microsoft\Windows\CurrentVersion\Policies -Name Associations
Pop-Location
New-ItemProperty -name LowRiskFileTypes -propertyType string HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations -value ".exe;.bat;.msi;.reg;.ps1;.vbs"
