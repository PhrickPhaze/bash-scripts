##########################################################
##########################################################
##    _    _           _                                ##
##   | |  | |         | |                               ##
##   | |__| | ___  ___| |_ _ __   __ _ _ __ ___   ___   ##
##   |  __  |/ _ \/ __| __| '_ \ / _` | '_ ` _ \ / _ \  ##
##   | |  | | (_) \__ \ |_| | | | (_| | | | | | |  __/  ##
##   |_|  |_|\___/|___/\__|_| |_|\__,_|_| |_| |_|\___|  ##
##                                                      ##
##########################################################
##########################################################
#----------------------------INFORMATION-----------------------------#
#                                                                    |
# This script is for the host machine to change its hostname for     |
# easier access and a known hostname for the administrator.          |
#--------------------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# Prompts the user for the value for 
# the new hostname.
$vm = Read-Host "New hostname"

# The variable with the user input is 
# inserted to change the hostname and 
# restart the machine.
Rename-Computer -NewName $vm -Restart