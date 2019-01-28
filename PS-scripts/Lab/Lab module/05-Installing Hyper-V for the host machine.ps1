###########################################################
###########################################################
##    _    _                                 __      __  ##
##   | |  | |                                \ \    / /  ##
##   | |__| |_   _ _ __   ___ _ __   ______   \ \  / /   ##
##   |  __  | | | | '_ \ / _ \ '__| |______|   \ \/ /    ##
##   | |  | | |_| | |_) |  __/ |                \  /     ##
##   |_|  |_|\__, | .__/ \___|_|                 \/      ##
##            __/ | |                                    ##
##           |___/|_|                                    ##
##                                                       ##
###########################################################
###########################################################
#-----------------------INFORMATION-----------------------#
#                                                         |
# This script installs the Hyper-V role to the host       |
# machine.                                                |
#---------------------------------------------------------#


# This lists the available modules for Hyper-V to be installed
Get-WindowsFeature -Name *Hyper-V*

# This command installs the Hyper-V role with PowerShell and restarts the machine after it's done.
Install-WindowsFeature -Name Hyper-V -ComputerName DC1 -IncludeManagementTools -Restart

# This checks what Hyper-V modules are already installed on the host
Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | select DisplayName, FeatureName

# These cmdlets downloads and installs the Hyper-V module for administration with PowerShell
# and the RSAT tools to administer Active Directory through PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
Install-WindowsFeature -Name Hyper-V, RSAT-Hyper-V-Tools

# For a final confirmation that Hyper-V is installed in your environment, run this command
Get-WindowsFeature *hyper-v*