#########################################################
#########################################################
##     _____ _             _    __      ____  __       ##
##    / ____| |           | |   \ \    / /  \/  |      ##
##   | (___ | |_ __ _ _ __| |_   \ \  / /| \  / |___   ##
##    \___ \| __/ _` | '__| __|   \ \/ / | |\/| / __|  ##
##    ____) | || (_| | |  | |_     \  /  | |  | \__ \  ##
##   |_____/ \__\__,_|_|   \__|     \/   |_|  |_|___/  ##
##                                                     ##
##                                                     ##
#########################################################
#########################################################
#-----------------------INFORMATION---------------------#
#                                                       |
# Simply put, this script starts VMs one at a time.     |
#-------------------------------------------------------#

# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (!( $isAdmin )) {
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan ; Start-Sleep -Seconds 1
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    exit
}

# User is asked which VM to start
$vm = Read-Host "Enter VM name to boot"
Start-VM -Name $vm 