#############################################################################
#############################################################################
##             _____    _____   _____    _____  _   _  _____               ##
##       /\   |  __ \  |  __ \ / ____|  |  __ \| \ | |/ ____|              ##
##      /  \  | |  | | | |  | | (___    | |  | |  \| | (___                ##
##     / /\ \ | |  | | | |  | |\___ \   | |  | | . ` |\___ \               ##
##    / ____ \| |__| | | |__| |____) |  | |__| | |\  |____) |              ##
##   /_/___ \_\_____/ _|_____/|_____( ) |_____/|_| \_|_____/               ##
##   |  __ \ / ____| |  __ \        |/               | | (_)               ##
##   | |  | | |      | |__) | __ ___  _ __ ___   ___ | |_ _  ___  _ __     ##
##   | |  | | |      |  ___/ '__/ _ \| '_ ` _ \ / _ \| __| |/ _ \| '_ \    ##
##   | |__| | |____  | |   | | | (_) | | | | | | (_) | |_| | (_) | | | |   ##
##   |_____/ \_____| |_|   |_|  \___/|_| |_| |_|\___/ \__|_|\___/|_| |_|   ##
##                                                                         ##
##                                                                         ##
#############################################################################
#############################################################################
#------------------------------INFORMATION----------------------------------#
#                                                                           |
# This script installs the Active Directory Domain Services and the DNS Role|
# to the host machine and then promotes it to a domain controller. This is  |
# the first domain controller in the forest which is why the forest is      |
# created along with the creation of the domain.                            |
#---------------------------------------------------------------------------#

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