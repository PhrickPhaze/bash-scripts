﻿#############################################################################
#############################################################################
##    _    _           _     _____ _____             _____  _   _  _____   ##
##   | |  | |         | |   |_   _|  __ \    ___    |  __ \| \ | |/ ____|  ##
##   | |__| | ___  ___| |_    | | | |__) |  ( _ )   | |  | |  \| | (___    ##
##   |  __  |/ _ \/ __| __|   | | |  ___/   / _ \/\ | |  | | . ` |\___ \   ##
##   | |  | | (_) \__ \ |_   _| |_| |      | (_>  < | |__| | |\  |____) |  ##
##   |_|  |_|\___/|___/\__| |_____|_|       \___/\/ |_____/|_| \_|_____/   ##
##                                                                         ##
##                                                                         ##
#############################################################################
#############################################################################
#-------------------------------INFORMATION---------------------------------#
#                                                                           |
# This script sets a static IP address on the host and configures the DNS so|
# the administrator knows what IP address resolves hostnames for the VMs.   |
#---------------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Presenting the network adapters.
Get-NetAdapter

# Telling the user that the second adapter (LAN) will be static 
# and act as a DHCP server.
Write-host ""
Write-host "The script sets 'Ethernet 2' with static configuration and DHCP"
Write-host ""

# Variables
$ip = Read-host "Enter IP address"
$netmask = Read-Host "Bits in subnet mask"
$gateway = Read-Host "Default gateway"
$dns1 = Read-Host "Primary DNS"
$dns2 = Read-Host "Secondary DNS"

# Applying the varibles to set a new IP, netmask, gateway and DNS
New-NetIPAddress -InterfaceAlias 'Ethernet 2' -IPAddress $ip -PrefixLength $netmask -DefaultGateway $gateway -ErrorAction SilentlyContinue
Set-DnsClientServerAddress -InterfaceAlias 'Ethernet 2' -ServerAddresses $dns1,$dns2 -ErrorAction SilentlyContinue