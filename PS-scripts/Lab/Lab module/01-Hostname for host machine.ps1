# Prompts the user for the value for 
# the new hostname.
$vm = Read-Host "New hostname"

# The variable with the user input is 
# inserted to change the hostname and 
# restart the machine.
Rename-Computer -NewName $vm -Restart