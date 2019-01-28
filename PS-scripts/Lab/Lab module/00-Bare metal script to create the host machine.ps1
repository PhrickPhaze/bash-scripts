# This lists the available modules for Hyper-V to be installed
Get-WindowsFeature -Name *Hyper-V*

# This command installs the Hyper-V role with PowerShell and restarts the machine after it's done.
Install-WindowsFeature -Name Hyper-V -ComputerName DC1 -IncludeManagementTools -Restart

# This checks what Hyper-V modules are already installed on the host
Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | select DisplayName, FeatureName

# These cmdlets downloads and installs the Hyper-V module for administration with PowerShell
# and the RSAT tools to administer Active Directory through PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
Install-WindowsFeature -Name Hyper-V, RSAT-Hyper-V-Tools

# For a final confirmation that Hyper-V is installed in your environment, run this command
Get-WindowsFeature *hyper-v*


# This code removes all default network switches that are installed with Hyper-V
Remove-VMSwitch * -Force

# This lists available adapters 
Get-NetAdapter
Write-Host ""

# Variables
$adapter = Get-NetAdapter | Select-Object -First 1
$name = Read-Host "Enter new switch name(external)"

# This piece of code creates a new virtual external switch to the LAN adapter
New-VMSwitch -Name $name -AllowManagementOS $True -NetAdapterName $adapter.name

# This lists available adapters 
Get-NetAdapter
Write-Host ""

# Variables
$adapter = Get-NetAdapter | Select-Object -Last 1
$name = Read-Host "Enter new switch name(LAN)"

# This piece of code creates a new virtual external switch to the LAN adapter
New-VMSwitch -Name $name -AllowManagementOS $True -NetAdapterName $adapter.name

$external = Get-VMSwitch | Select-Object -First 1
$internal = Get-VMSwitch | Select-Object -Last 1

# Creates the host machine in Hyper-V
$vmname = Read-Host "Enter VM name for host machine"
$mem = Read-Host "Enter RAM (in GB)"
$RAM = [int64]$mem * 1GB
New-VM -Name $vmname -MemoryStartupBytes $RAM -SwitchName $external
Add-VMNetworkAdapter -VMName $vmname -Name $internal