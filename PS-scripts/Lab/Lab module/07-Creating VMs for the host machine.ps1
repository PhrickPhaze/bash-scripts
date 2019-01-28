########################################################################
########################################################################
##     _____                _   _              __      ____  __       ##
##    / ____|              | | (_)             \ \    / /  \/  |      ##
##   | |     _ __ ___  __ _| |_ _ _ __   __ _   \ \  / /| \  / |___   ##
##   | |    | '__/ _ \/ _` | __| | '_ \ / _` |   \ \/ / | |\/| / __|  ##
##   | |____| | |  __/ (_| | |_| | | | | (_| |    \  /  | |  | \__ \  ##
##    \_____|_|  \___|\__,_|\__|_|_| |_|\__, |     \/   |_|  |_|___/  ##
##                                       __/ |                        ##
##                                      |___/                         ##
##                                                                    ##
########################################################################
########################################################################
#-----------------------------INFORMATION------------------------------#
#                                                                      |
# This is the script that creates VMs. It requires all the previous    |
# scripts to have been executed and needs the .vhd files to act as     |
# parent disks.                                                        |
#----------------------------------------------------------------------#

# Variables
$VM = Read-Host "Enter new VM name"
$VMPath = Read-Host "Enter path for VM"
New-Item -ItemType Directory -Path $VMPath -ErrorAction SilentlyContinue
$VMDiskPath = Read-Host "Enter path for virtual harddisk"
New-Item -ItemType Directory -Path $VMDiskPath -ErrorAction SilentlyContinue
$diskname = Read-Host "Enter disk name with extension (.vhd or .vhdx)"
$vdisk = $VMDiskPath + "\" + $diskname
$parent = Read-Host "Enter parent path"
$gen = Read-Host "Enter VM generation"
$mem = Read-Host "Enter RAM(in GB)"
$RAM = [int64]$mem * 1GB

Get-VMSwitch | Format-Table

# User is first presented with available switches and then 
# is asked to choose which one to attach to the VM.
$Switch = Read-Host "Enter switch to be attached to VM"


# Creates the actual VM.
New-VM -Name $VM -Generation $gen -path $VMPath -MemoryStartupBytes $RAM -SwitchName $Switch

# Creates the virtual harddisk and attaches it to a parentpath.
New-VHD -Path $vdisk -Differencing -ParentPath $parent

# Adds the differencing disk to the VM
Add-VMHardDiskDrive -VMName $VM -ControllerType IDE -ControllerNumber 0 -ControllerLocation 1 -Path $vdisk