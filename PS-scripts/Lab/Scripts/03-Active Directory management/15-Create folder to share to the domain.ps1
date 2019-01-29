#######################################################
#######################################################
##     _____ _                       __              ##
##    / ____| |                     / _|             ##
##   | (___ | |__   __ _ _ __ ___  | |_ ___  _ __    ##
##    \___ \| '_ \ / _` | '__/ _ \ |  _/ _ \| '__|   ##
##    ____) | | | | (_| | | |  __/ | || (_) | |      ##
##   |_____/|_| |_|\__,_|_|  \___| |_| \___/|_|      ##
##   | | | |                   | |         | |       ##
##   | |_| |__   ___  __      _| |__   ___ | | ___   ##
##   | __| '_ \ / _ \ \ \ /\ / / '_ \ / _ \| |/ _ \  ##
##   | |_| | | |  __/  \ V  V /| | | | (_) | |  __/  ##
##    \__|_| |_|\___|   \_/\_/ |_|_|_|\___/|_|\___|  ##
##       | |                     (_)                 ##
##     __| | ___  _ __ ___   __ _ _ _ __             ##
##    / _` |/ _ \| '_ ` _ \ / _` | | '_ \            ##
##   | (_| | (_) | | | | | | (_| | | | | |           ##
##    \__,_|\___/|_| |_| |_|\__,_|_|_| |_|           ##
##                                                   ##
##                                                   ##
#######################################################
#######################################################
#-------------------INFORMATION-----------------------#
#                                                     |
# This script creates a share that everyone in the    |
# domain can modify/change.                           |
#-----------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Importing the Active Directory module
Import-Module activedirectory

# Variables
$vm = Read-Host "Enter VM name"
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$folder = Read-Host "Enter folder name and path to create share to the domain"
$share = Read-Host "Enter share name"

# Creating the folder
$scriptblock =
{param($folder1)
New-Item $folder1 -Type Directory -ErrorAction SilentlyContinue
}
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $folder
Remove-PSSession $vm

# Creating the share and managing permissions
$cim = New-CimSession -ComputerName $vm
New-SmbShare -Name $share -Path $folder -CimSession $cim
Revoke-SmbShareAccess -Name $share -AccountName "Everyone" -Force -CimSession $cim
Grant-SmbShareAccess -Name $share -AccountName "Authenticated Users" -AccessRight Change -Force -CimSession $cim
Remove-CimSession $vm