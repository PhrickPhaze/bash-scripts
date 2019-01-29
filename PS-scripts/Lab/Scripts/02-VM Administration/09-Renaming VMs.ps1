###############################################################################
###############################################################################
##    _____                            _              __      ____  __       ##
##   |  __ \                          (_)             \ \    / /  \/  |      ##
##   | |__) |___ _ __   __ _ _ __ ___  _ _ __   __ _   \ \  / /| \  / |___   ##
##   |  _  // _ \ '_ \ / _` | '_ ` _ \| | '_ \ / _` |   \ \/ / | |\/| / __|  ##
##   | | \ \  __/ | | | (_| | | | | | | | | | | (_| |    \  /  | |  | \__ \  ##
##   |_|  \_\___|_| |_|\__,_|_| |_| |_|_|_| |_|\__, |     \/   |_|  |_|___/  ##
##                                              __/ |                        ##
##                                             |___/                         ##
##                                                                           ##
###############################################################################
###############################################################################
#---------------------------------INFORMATION---------------------------------#
#                                                                             |
# This script expects VMs to be in a running state and proceeds to change     |
# their hostnames.                                                            |
#-----------------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Variables
$vmname = Read-Host "Enter VM name do you wish to rename"
$vm = Read-Host "Enter new VM hostname"
$cred = Get-Credential -Credential "$vmname\Administrator"
$session = New-PSSession -VMName $vmname -Credential $cred

# Using a PowerShell Session to acces the VM and renames its hostname
$sb = {param($SBvmname) Rename-Computer -NewName $SBvmname -Restart}
Invoke-Command -Session $session -ScriptBlock $sb -ArgumentList $vm
Remove-PSSession -VMName $vmname