##############################################################################
##############################################################################
##    _____  _    _  _____ _____              _____                         ##
##   |  __ \| |  | |/ ____|  __ \    ___     / ____|                        ##
##   | |  | | |__| | |    | |__) |  ( _ )   | (___   ___ ___  _ __   ___    ##
##   | |  | |  __  | |    |  ___/   / _ \/\  \___ \ / __/ _ \| '_ \ / _ \   ##
##   | |__| | |  | | |____| |      | (_>  <  ____) | (_| (_) | |_) |  __/   ##
##   |_____/|_|  |_|\_____|_|       \___/\/ |_____/ \___\___/| .__/ \___|   ##
##                                                           | |            ##
##                                                           |_|            ##
##############################################################################
##############################################################################
#--------------------------------INFORMATION---------------------------------#
#                                                                            |
# This script adds the DHCP role to the host machine and adds a scope to it  |
# that will be used by the VMs later on.                                     |
#----------------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Variables
$hostname = Read-Host "Enter hostname"
$domain = Read-Host "Enter domain name"
$fqdn = "$hostname.$domain"
$scope = Read-Host "Enter scope name"
$ip = Read-host "Enter IP adress"
$start = Read-host "Enter start address"
$end = Read-Host "Enter end address"
$netmask = Read-host "Enter netmask"

# Installing the DHCP role to the machine.
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools

# This completes the post-deployment configuration for DHCP.
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12" -Name "ConfigurationState" -Value 2

# This part is skippable but added in to be consistent.
Import-Module *DHCP*

# This authorizes DHCP in a domain controller.
Add-DhcpServerInDC -DnsName $fqdn -IPAddress $ip

#This adds a DHCP Security Group in case it's needed.
Add-DhcpServerSecurityGroup

# Here the script finally adds a new scope to be used by the VMs.
Add-DhcpServerv4Scope `
    -Name "$scope" `
    -StartRange $start `
    -EndRange $end `
    -SubnetMask $netmask `
    -LeaseDuration (New-TimeSpan -Days 7) `
    -State Active

# These variables are needed for the part below
$scopeid = Get-DhcpServerv4Scope | select scopeid | Format-Table -HideTableHeaders | Out-String
$id = [IPAddress]$scopeid.trim()

# This adds DNS functionality to the DHCP scope
Set-DHCPServerv4OptionValue -ScopeID $id -router $ip -DnsDomain $domain -DnsServer $ip -WarningAction SilentlyContinue

# Finally the script restarts the DHCP server 
Restart-Service DHCPServer -WarningAction SilentlyContinue