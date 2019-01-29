###############################################################
###############################################################
##    _   _      _                      _    _               ##
##   | \ | |    | |                    | |  (_)              ##
##   |  \| | ___| |___      _____  _ __| | ___ _ __   __ _   ##
##   | . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ / | '_ \ / _` |  ##
##   | |\  |  __/ |_ \ V  V / (_) | |  |   <| | | | | (_| |  ##
##   |_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\_|_| |_|\__, |  ##
##                                                    __/ |  ##
##                                                   |___/   ##
##                                                           ##
###############################################################
###############################################################
#-------------------------INFORMATION-------------------------#
#                                                             |
# This script first removes all the defauls network switches  |
# from Hyper-V that are installed with the role, then it      |
# adds a new network switch that the VMs will be connected to.|
#-------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# This code removes all default network switches that are installed with Hyper-V
Remove-VMSwitch * -Force

# This lists available adapters 
Get-NetAdapter
Write-Host ""

# Variables
$adapter = Get-NetAdapter | Select-Object -Last 1
$name = Read-Host "Enter new switch name"

# This piece of code creates a new virtual external switch to the LAN adapter
New-VMSwitch -Name $name -AllowManagementOS $True -NetAdapterName $adapter.name