##################################################################################################
##################################################################################################
##         _       _        __      ____  __   _              _                       _         ##
##        | |     (_)       \ \    / /  \/  | | |            | |                     (_)        ##
##        | | ___  _ _ __    \ \  / /| \  / | | |_ ___     __| | ___  _ __ ___   __ _ _ _ __    ##
##    _   | |/ _ \| | '_ \    \ \/ / | |\/| | | __/ _ \   / _` |/ _ \| '_ ` _ \ / _` | | '_ \   ##
##   | |__| | (_) | | | | |    \  /  | |  | | | || (_) | | (_| | (_) | | | | | | (_| | | | | |  ##
##    \____/ \___/|_|_| |_|     \/   |_|  |_|  \__\___/   \__,_|\___/|_| |_| |_|\__,_|_|_| |_|  ##
##                                                                                              ##
##                                                                                              ##
##################################################################################################
##################################################################################################
#-----------------------------------------INFORMATION--------------------------------------------#
#                                                                                                |
# This script is used to add a VM to a domain, preferably the one the host machine is in for     |
# easier AD management.                                                                          |
#------------------------------------------------------------------------------------------------#

# Variables
$vm = Read-Host "Enter VM name"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$domain = Read-Host "Enter domain name"
$dn,$tld = $domain.Split('.')

# Uses the variables to add the VM to a domain
$scriptblock = {param($domain1,$dn1)
$cred1 = Get-Credential -Credential "$dn1\Administrator"
Add-Computer -DomainName $domain1 -Credential $cred1 -Restart -Force
}
Invoke-Command -Session $session -ScriptBlock $scriptblock -ArgumentList $domain,$dn
Remove-PSSession $vm