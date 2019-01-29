#########################################################################
#########################################################################
##             _____    _____   _____    _____  _   _  _____            ##
##       /\   |  __ \  |  __ \ / ____|  |  __ \| \ | |/ ____|           ##
##      /  \  | |  | | | |  | | (___    | |  | |  \| | (___             ##
##     / /\ \ | |  | | | |  | |\___ \   | |  | | . ` |\___ \            ##
##    / ____ \| |__| | | |__| |____) |  | |__| | |\  |____) |           ##
##   /_/___ \_\_____/  |_____/|_____( ) |_____/|_| \_|_____( )          ##
##   |  __ \ / ____|                |/                  / _|/           ##
##   | |  | | |       _ __  _ __ ___  _ __ ___   ___   | |_ ___  _ __   ##
##   | |  | | |      | '_ \| '__/ _ \| '_ ` _ \ / _ \  |  _/ _ \| '__|  ##
##   | |__| | |____  | |_) | | | (_) | | | | | | (_) | | || (_) | |     ##
##   |_____/ \_____|_| .__/|_|  \___/|_| |_| |_|\___/  |_| \___/|_|     ##
##   \ \    / /  \/  | |                                                ##
##    \ \  / /| \  / |_|_                                               ##
##     \ \/ / | |\/| / __|                                              ##
##      \  /  | |  | \__ \                                              ##
##       \/   |_|  |_|___/                                              ##
##                                                                      ##
##                                                                      ##
##########################################################################
##########################################################################
#------------------------------INFORMATION-------------------------------#
#                                                                        |
# This installs AD DS, DNS and all of their depenencies with their       |
# management tools first and then promotes the VM to a domain controller.|
#------------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Variables
$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred

# Presenting AD and DNS features that can be installed
$scriptblock = {Get-WindowsFeature -Name AD*, DNS}
Invoke-Command -Session $session -ScriptBlock $scriptblock | select DisplayName, Name, InstallState 

# Installing AD DS, DNS and all of their depenencies along with management tools
$install = {Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeAllSubFeature -IncludeManagementTools -Restart}
Invoke-Command -Session $session -ScriptBlock $install 

# Presents installed AD modules
$sb = {Get-Command -Module ADDSDeployment}
Invoke-Command -Session $session -ScriptBlock $scriptblock 

# Promotes the VM to a domain controller
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