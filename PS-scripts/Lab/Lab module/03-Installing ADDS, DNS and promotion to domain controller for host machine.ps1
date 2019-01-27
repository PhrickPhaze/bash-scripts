# Presenting Active Directory and DNS modules available to install
Get-WindowsFeature -Name AD*, DNS

# Awaiting user input to begin the installation
Read-Host 'Press 'Enter' to install ADDS and DNS, and promote the machine to domain controller'

# Installing ADDS services and DNS to this machine including dependencies and management tools.
Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeAllSubFeature -IncludeManagementTools

# Presenting installed AD Deployment modules in current state
Get-Command -Module ADDSDeployment

# Variables
$domain = Read-Host "Enter domain name"
$dn, $netbios = $domain.split('.')
$netb = $dn.toupper()

# Promoting the machine to a domain controller
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath “C:\Windows\NTDS” `
-DomainMode “Win2012R2” `
-DomainName “$domain” `
-DomainNetbiosName “$netb” `
-ForestMode “Win2012R2” `
-InstallDns:$true `
-LogPath “C:\Windows\NTDS” `
-NoRebootOnCompletion:$false `
-SysvolPath “C:\Windows\SYSVOL” `
-Force:$true