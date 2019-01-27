# Variables
$vmname = Read-Host "Enter VM name do you wish to rename"
$vm = Read-Host "Enter new VM hostname"
$cred = Get-Credential -Credential "$vmname\Administrator"
$session = New-PSSession -VMName $vmname -Credential $cred

# Using a PowerShell Session to acces the VM and renames its hostname
$sb = {param($SBvmname) Rename-Computer -NewName $SBvmname -Restart}
Invoke-Command -Session $session -ScriptBlock $sb -ArgumentList $vm
Remove-PSSession -VMName $vmname