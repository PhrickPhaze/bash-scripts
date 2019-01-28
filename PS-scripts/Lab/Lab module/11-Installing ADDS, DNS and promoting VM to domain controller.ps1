# Variables
$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred


$scriptblock = {Get-WindowsFeature -Name AD*, DNS}
Invoke-Command -Session $session -ScriptBlock $scriptblock | select DisplayName, Name, InstallState 

$install = {Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeAllSubFeature -IncludeManagementTools -Restart}
Invoke-Command -Session $session -ScriptBlock $install 

$sb = {Get-Command -Module ADDSDeployment}
Invoke-Command -Session $session -ScriptBlock $scriptblock 

$sb = {
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')
$cred1 = Get-Credential -Credential "$dn\Administrator"
Install-ADDSDomainController `
-Credential $cred1 `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath 'C:\Windows\NTDS' `
-DomainName $domain `
-InstallDns:$true `
-LogPath 'C:\Windows\NTDS' `
-NoRebootOnCompletion:$false `
-SysvolPath 'C:\Windows\SYSVOL' `
-Force:$true
}
Invoke-Command -Session $session -ScriptBlock $sb -ArgumentList $domain,$dn
Remove-PSSession $session