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

# Prompts the user for the value for 
# the new hostname.
$vm = Read-Host "New hostname"

# The variable with the user input is 
# inserted to change the hostname and 
# restart the machine.
Rename-Computer -NewName $vm -Restart