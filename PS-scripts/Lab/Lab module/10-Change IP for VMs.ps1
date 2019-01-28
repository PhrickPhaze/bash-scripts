########################################################################################
########################################################################################
##     _____ _                 _              __      ____  __         _____ _____    ##
##    / ____| |               (_)             \ \    / /  \/  |       |_   _|  __ \   ##
##   | |    | |__   __ _ _ __  _ _ __   __ _   \ \  / /| \  / |___      | | | |__) |  ##
##   | |    | '_ \ / _` | '_ \| | '_ \ / _` |   \ \/ / | |\/| / __|     | | |  ___/   ##
##   | |____| | | | (_| | | | | | | | | (_| |    \  /  | |  | \__ \    _| |_| |       ##
##    \_____|_| |_|\__,_|_| |_|_|_| |_|\__, |     \/   |_|  |_|___/   |_____|_|       ##
##                                      __/ |                                         ##
##                                     |___/                                          ##
##                                                                                    ##
########################################################################################
########################################################################################
#------------------------------------INFORMATION---------------------------------------#
#                                                                                      |
# After changing hostnames in the previous script, this script changes the IP-addresses|
# of the VMs, which can come in handy if new VMs are added to the domain to know where |
# to resolve the domain name to a static IP of a domain controller.                    |
#--------------------------------------------------------------------------------------#

# Variables
$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$ip = Read-Host "Enter new IP address"
$prefix = Read-Host "Enter number of bits in subnet mask"
$gateway = Read-Host "Enter default gateway"
$dns1 = Read-Host "Enter primary DNS"
$dns2 = Read-Host "Enter secondary DNS"

# Informs the user that the second adapter will be used assigned to VMs
Get-NetAdapter
Write-Host ""
Write-Host "The second adapter (LAN) will be assigned to VMs"

# This is were all the variables are utilized to change the IP address of the VM.
$scriptblock = {param($ip1,$prefix1,$gateway1,$dns1a,$dns2a)
$net = Get-NetAdapter | select -Last 1 name
New-NetIPAddress -InterfaceAlias $net.name -IPAddress $ip1 -PrefixLength $prefix1 -DefaultGateway $gateway1
Set-DnsClientServerAddress -InterfaceAlias $net.name -ServerAddresses $dns1a,$dns2a
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $ip,$prefix,$gateway,$dns1,$dns2
Remove-PSSession -Session $session