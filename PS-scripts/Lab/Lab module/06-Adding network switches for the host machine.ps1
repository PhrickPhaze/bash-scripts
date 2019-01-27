# This code removes all default network switches that are installed with Hyper-V
Remove-VMSwitch * -Force

# This lists available adapters 
Get-NetAdapter
Write-Host ""

# Variables
$adapter = Get-NetAdapter | Select-Object -Last 1
$name = Read-Host "Enter new switch name"

# This piece of code creates a new virtual external switch to the LAN adapter
New-VMSwitch -Name $name -AllowManagementOS $True -NetAdapterName $adapter.name