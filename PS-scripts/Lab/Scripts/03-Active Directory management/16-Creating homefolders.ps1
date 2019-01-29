#####################################################################
#####################################################################
##    _    _                       __      _     _                 ##
##   | |  | |                     / _|    | |   | |                ##
##   | |__| | ___  _ __ ___   ___| |_ ___ | | __| | ___ _ __ ___   ##
##   |  __  |/ _ \| '_ ` _ \ / _ \  _/ _ \| |/ _` |/ _ \ '__/ __|  ##
##   | |  | | (_) | | | | | |  __/ || (_) | | (_| |  __/ |  \__ \  ##
##   |_|  |_|\___/|_| |_| |_|\___|_| \___/|_|\__,_|\___|_|  |___/  ##
##                                                                 ##
##                                                                 ##
#####################################################################
#####################################################################
#----------------------------INFORMATION----------------------------#
#                                                                   |
# This script creates a folder, shares it and then creates a folder |
# for each and every user imported from the .csv file inside the    |
# initial folder. After that it modifies permissions so only admins |
# and the user can access that folder. That folder will be their    |
# homefolder where they store their personal files.                 |
#-------------------------------------------------------------------#

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
$folderpath = Read-Host "Enter name and path to homefolders"
$sharename = Read-Host "Enter share name"
$csvpath = Read-Host "Enter .csv path"

# Creating the root homefolder catalog
$sb = 
{param($folderpath1)
New-Item -ItemType Directory -Path $folderpath1
}
Invoke-Command -Session $session -ScriptBlock $sb -ArgumentList $folderpath
Remove-PSSession $vm

# Creates a share for the root homefolder catalog
$cim = New-CimSession -ComputerName $vm
New-SmbShare -Name $sharename -Path $folderpath -CimSession $cim
Grant-SmbShareAccess -Name $sharename -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Revoke-SmbShareAccess -Name $sharename -AccountName "Everyone" -Force -CimSession $cim

# Creates a new folder for every user inside the root homefolder catalog
$users = Import-Csv $csvpath | select -expand username
ForEach ($u in $users)
{
New-Item -ItemType Directory -Path \\$vm\$sharename\$u
}

# Sets the appropirate permissions on every user folder within the root homefolder catalog
$ADUsers = Import-Csv $csvpath | select -expand username
ForEach ($ADUser in $ADUsers)
{
$cim = New-CimSession -ComputerName SRV1
New-SmbShare -Name "$ADUser" -Path "$folderpath\$ADUser" -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName $ADUser -AccessRight Change -Force -CimSession $cim
Revoke-SmbShareAccess -Name $ADUser -AccountName "Everyone" -Force -CimSession $cim
}