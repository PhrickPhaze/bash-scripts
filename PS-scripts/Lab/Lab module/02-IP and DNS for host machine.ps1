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