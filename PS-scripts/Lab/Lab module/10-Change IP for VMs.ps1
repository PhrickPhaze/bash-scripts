$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$ip = Read-Host "Enter new IP address"
$prefix = Read-Host "Enter number of bits in subnet mask"
$gateway = Read-Host "Enter default gateway"
$dns1 = Read-Host "Enter primary DNS"
$dns2 = Read-Host "Enter secondary DNS"

Get-NetAdapter
Write-Host ""
Write-Host "The second adapter (LAN) will be assigned to VMs"

$scriptblock = {param($ip1,$prefix1,$gateway1,$dns1a,$dns2a)
$net = Get-NetAdapter | select -Last 1 name
New-NetIPAddress -InterfaceAlias $net.name -IPAddress $ip1 -PrefixLength $prefix1 -DefaultGateway $gateway1
Set-DnsClientServerAddress -InterfaceAlias $net.name -ServerAddresses $dns1a,$dns2a
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $ip,$prefix,$gateway,$dns1,$dns2
Remove-PSSession -Session $session