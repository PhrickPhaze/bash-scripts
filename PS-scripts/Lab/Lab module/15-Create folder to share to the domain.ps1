$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')
$folder = Read-Host "Enter folder name and path to create share to the domain"
$share = Read-Host "Enter share name"
$scriptblock =
{param($folder1)
New-Item $folder1 -Type Directory -ErrorAction SilentlyContinue
}
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $folder
Remove-PSSession $vm

$cim = New-CimSession -ComputerName $vm
New-SmbShare -Name $share -Path $folder -CimSession $cim
Revoke-SmbShareAccess -Name $share -AccountName "Everyone" -Force -CimSession $cim
Grant-SmbShareAccess -Name $share -AccountName "Authenticated Users" -AccessRight Change -Force -CimSession $cim
Remove-CimSession $vm