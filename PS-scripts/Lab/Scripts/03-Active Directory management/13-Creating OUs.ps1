######################################################################
######################################################################
##     _____                _   _                ____  _    _       ##
##    / ____|              | | (_)              / __ \| |  | |      ##
##   | |     _ __ ___  __ _| |_ _ _ __   __ _  | |  | | |  | |___   ##
##   | |    | '__/ _ \/ _` | __| | '_ \ / _` | | |  | | |  | / __|  ##
##   | |____| | |  __/ (_| | |_| | | | | (_| | | |__| | |__| \__ \  ##
##    \_____|_|  \___|\__,_|\__|_|_| |_|\__, |  \____/ \____/|___/  ##
##                                       __/ |                      ##
##                                      |___/                       ##
##                                                                  ##
######################################################################
######################################################################
#----------------------------INFORMATION-----------------------------#
#                                                                    |
# This small script creates OUs in the domain.                       |
#--------------------------------------------------------------------#

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
$OUname = Read-Host "Enter new OU name"
$OUpath = Read-Host "Enter full path to OU"

# Creates an OU in a desired place
New-ADOrganizationalUnit -Name $OUname -Path $OUpath
