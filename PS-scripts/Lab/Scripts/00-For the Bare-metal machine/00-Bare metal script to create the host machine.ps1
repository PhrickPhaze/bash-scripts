####################################################################
####################################################################
##    _____                               _     _ _               ##
##   |  __ \                             (_)   (_) |              ##
##   | |__) | __ ___ _ __ ___  __ _ _   _ _ ___ _| |_ ___  ___    ##
##   |  ___/ '__/ _ \ '__/ _ \/ _` | | | | / __| | __/ _ \/ __|   ##
##   | |   | | |  __/ | |  __/ (_| | |_| | \__ \ | ||  __/\__ \   ##
##   |_|__ |_|  \___|_|  \___|\__, |\__,_|_|___/_|\__\___||___/   ##
##   |  _ \                      | |       | |      | |           ##
##   | |_) | __ _ _ __ ___   _ __|_|_   ___| |_ __ _| |           ##
##   |  _ < / _` | '__/ _ \ | '_ ` _ \ / _ \ __/ _` | |           ##
##   | |_) | (_| | | |  __/ | | | | | |  __/ || (_| | |           ##
##   |____/ \__,_|_|  \___| |_| |_| |_|\___|\__\__,_|_|           ##
##                                                                ##
####################################################################
####################################################################
#----------------------------INFORMATION-----------------------------#
#                                                                    |
# This script is for the bare metal machine to create the host       |
# machine by installing the Hyper-V role first, then the networking  | 
# and finally the actual VM. It'll have 2 network adapters           |
# (WAN and LAN) and the nested VMs will be attached to the           |
# LAN-adapter to be isolated from everything else. The recommanded   |
# amount of RAM is either 16GB or 32GB depending on how big you      |
# want to make the lab environment.                                  |
#--------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

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

# Sets variables to each switch
$external = Get-VMSwitch | Select-Object -First 1
$internal = Get-VMSwitch | Select-Object -Last 1

# Creates the host machine in Hyper-V
$vmname = Read-Host "Enter VM name for host machine"
$mem = Read-Host "Enter RAM (in GB)"
$RAM = [int64]$mem * 1GB
$disk = Read-Host "Enter path to virtual disk"
$parent = Read-Host "Enter path to parent disk"
New-VM -Name $vmname -MemoryStartupBytes $RAM -SwitchName $external
Add-VMNetworkAdapter -VMName $vmname -Name $internal
New-VHD -Path $disk -Differencing -ParentPath $parent

# This makes nested virtualization possible on the vm
Set-VMProcessor -VMName $vmname -ExposeVirtualizationExtensions $true

# Starting the vm
Start-VM -VMName $vmname