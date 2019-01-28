$vm = Read-Host "Enter VM name"
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$folderpath = Read-Host "Enter name and path to homefolders"
$sharename = Read-Host "Enter share name"
$csvpath = Read-Host "Enter .csv path"

$sb = 
{param($folderpath1)
New-Item -ItemType Directory -Path $folderpath1
}
Invoke-Command -Session $session -ScriptBlock $sb -ArgumentList $folderpath
Remove-PSSession $vm

$cim = New-CimSession -ComputerName $vm
New-SmbShare -Name $sharename -Path $folderpath -CimSession $cim
Grant-SmbShareAccess -Name $sharename -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Revoke-SmbShareAccess -Name $sharename -AccountName "Everyone" -Force -CimSession $cim

$users = Import-Csv $csvpath | select -expand username
ForEach ($u in $users)
{
New-Item -ItemType Directory -Path \\$vm\$sharename\$u
}



$ADUsers = Import-Csv $csvpath | select -expand username

ForEach ($ADUser in $ADUsers)
{
$cim = New-CimSession -ComputerName SRV1
New-SmbShare -Name "$ADUser" -Path "$folderpath\$ADUser" -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName $ADUser -AccessRight Change -Force -CimSession $cim
Revoke-SmbShareAccess -Name $ADUser -AccountName "Everyone" -Force -CimSession $cim
}