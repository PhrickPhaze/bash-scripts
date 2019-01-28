$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')

$scriptblock = {param($domain1,$dn1)
$cred1 = Get-Credential -Credential "$dn1\Administrator"
Add-Computer -DomainName $domain1 -Credential $cred1 -Restart -Force
}
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $domain,$dn
Remove-PSSession $vm