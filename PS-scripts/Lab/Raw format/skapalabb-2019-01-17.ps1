#################################################################
#################################################################
##  _____                                _____                 ##
## |  __ \                      ___     |  __ \                ##
## | |__) | __ ___  __ _ ___   ( _ )    | |__) |___  __ _ ___  ##
## |  ___/ '__/ _ \/ _` / __|  / _ \/\  |  _  // _ \/ _` / __| ##
## | |   | | |  __/ (_| \__ \ | (_>  <  | | \ \  __/ (_| \__ \ ##
## |_|   |_|  \___|\__, |___/  \___/\/  |_|  \_\___|\__, |___/ ##
##                    | |                              | |     ##
##                    |_|                              |_|     ##
##                                                             ##
#################################################################
################################################################# 
#
### This command installs the Hyper-V role with PowerShell and restarts the machine after it's done.
# Install-WindowsFeature -Name Hyper-V -ComputerName DC1 -IncludeManagementTools -Restart
#
### This checks what Hyper-V modules are already installed on the host
# Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | select DisplayName, FeatureName
#
### These cmdlets downloads and installs the Hyper-V module for administration with PowerShell
### and the RSAT tools to administer Active Directory through PowerShell
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
# Install-WindowsFeature -Name Hyper-V, RSAT-Hyper-V-Tools
#
### For a final confirmation that Hyper-V is installed in your environment, run this command
# Get-WindowsFeature *hyper-v*
#
#######
#
### The ISOs used for this lab environment are the following:
###   #-Windows Server 2016 x64
###   #-Windows Server 2019 x64
#
#######
#
#
############################################################
############################################################
##  _   _      _                      _    _              ##
## | \ | |    | |                    | |  (_)             ##
## |  \| | ___| |___      _____  _ __| | ___ _ __   __ _  ##
## | . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ / | '_ \ / _` | ##
## | |\  |  __/ |_ \ V  V / (_) | |  |   <| | | | | (_| | ##
## |_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\_|_| |_|\__, | ##
##                                                  __/ | ##
##                                                 |___/  ##
##                                                        ##
############################################################
############################################################                              
#
#
### This code removes all default network switches that are installed with Hyper-V
# Remove-VMSwitch * -Force
#
### This piece of code creates a new virtual external switch to the LAN adapter
# $switch = Get-NetAdapter -Name 'Ethernet 3'
# New-VMSwitch -Name "ExternalSwitch" -AllowManagementOS $True -NetAdapterName $switch.Name
#
#
#######
#
#
#######################################################################
#######################################################################
##    _____                _   _              __      ____  __       ##
##   / ____|              | | (_)             \ \    / /  \/  |      ##
##  | |     _ __ ___  __ _| |_ _ _ __   __ _   \ \  / /| \  / |___   ##
##  | |    | '__/ _ \/ _` | __| | '_ \ / _` |   \ \/ / | |\/| / __|  ##
##  | |____| | |  __/ (_| | |_| | | | | (_| |    \  /  | |  | \__ \  ##
##   \_____|_|  \___|\__,_|\__|_|_| |_|\__, |     \/   |_|  |_|___/  ##
##                                      __/ |                        ##
##                                     |___/                         ##
##                                                                   ##
#######################################################################
#######################################################################
#
### This code creates the VM 'DC2' with 4GB RAM and a 50GB .vhd file 
### and is attached to a W2019 .iso file. The VM is connected to the 
### previously created virtual switch.
#
### Variables
 $VM1 = "DC2"
 $VM1Path = "E:\DC2"
 $VM1DiskPath = "E:\DC2\VHDs\DC2_Disk1.vhd"
#
### Creates the actual VM.
 New-VM -Name $VM1 -Generation 1 -path $VM1Path -MemoryStartupBytes 4096MB -SwitchName "ExternalSwitch"
#
Add-VMHardDiskDrive -VMName $VM1 -ControllerType IDE -ControllerNumber 0 -ControllerLocation 1 -Path $VM1DiskPath
### Creates the .vhd for DC2.
# New-VHD $VM1DiskPath -SizeBytes 50GB -Dynamic
#
### Adds the .vhd to the VM.
# Add-VMHardDiskDrive -VMName DC2 -path $VM1DiskPath
#
### Adds a dvd-drive to the vm and attaches the .iso file to it.
# Set-VMDvdDrive -VMName DC2 -ControllerNumber 1 -Path "C:\ISOs\en_windows_server_2019_x64_dvd_4cb967d8.iso"
#
######################
#
### This code creates the VM 'DC3' with 4GB RAM and a 50GB .vhd file 
### and is attached to a W2019 .iso file. The VM is connected to the 
### previously created virtual switch.
#
### Variables
 $VM2 = "DC3"
 $VM2Path = "E:\DC3"
 $VM2DiskPath = "E:\DC3\VHDs\DC3_Disk1.vhd"
#
### Creates the actual VM.
 New-VM -Name $VM2 -Generation 1 -path $VM2Path -MemoryStartupBytes 4096MB -SwitchName "ExternalSwitch"
#
### Creates the .vhd for DC3.
 New-VHD $VM2DiskPath -SizeBytes 50GB -Dynamic
#
### Adds the .vhd to the VM.
 Add-VMHardDiskDrive -VMName $VM2 -path $VM2DiskPath
#
### Adds a dvd-drive to the vm and attaches the .iso file to it.
 Set-VMDvdDrive -VMName $VM2 -ControllerNumber 1 -Path "C:\ISOs\en_windows_server_2019_x64_dvd_4cb967d8.iso"
#
######################
#
### This code creates the VM 'SRV1' with 4GB RAM and a 50GB .vhd file 
### and is attached to a W2016 .iso file. The VM is connected to the 
### previously created virtual switch.
#
### Variables
 $VM3 = "SRV1"
 $VM3Path = "E:\SRV1"
 $VM3DiskPath = "E:\SRV1\VHDs\SRV1_Disk1.vhd"
#
### Creates the actual VM.
 New-VM -Name $VM3 -Generation 1 -path $VM3Path -MemoryStartupBytes 4096MB -SwitchName "ExternalSwitch"
#
### Creates the .vhd for SRV1.
# New-VHD $VM3DiskPath -SizeBytes 50GB -Dynamic
#
### Adds the .vhd to the VM.
 Add-VMHardDiskDrive -VMName $VM3 -path $VM3DiskPath
#
### Adds a dvd-drive to the vm and attaches the .iso file to it.
 Set-VMDvdDrive -VMName $VM3 -ControllerNumber 1 -Path "C:\ISOs\en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso"
#
######################
#
### This code creates the VM 'SRV2' with 4GB RAM and a 50GB .vhd file 
### and is attached to a W2016 .iso file. The VM is connected to the 
### previously created virtual switch.
#
### Variables
 $VM4 = "SRV2"
 $VM4Path = "E:\SRV2"
 $VM4DiskPath = "E:\SRV2\VHDs\SRV2_Disk1.vhd"
#
### Creates the actual VM.
 New-VM -Name $VM4 -Generation 1 -path $VM4Path -MemoryStartupBytes 4096MB -SwitchName "ExternalSwitch"
#
### Creates the .vhd for SRV2.
Get-Help New-VHD -ShowWindow $VM4DiskPath -SizeBytes 50GB -Dynamic
#
### Adds the .vhd to the VM.
 Add-VMHardDiskDrive -VMName $VM4 -path $VM4DiskPath

### Adds a dvd-drive to the vm and attaches the .iso file to it.
 Set-VMDvdDrive -VMName $VM4 -ControllerNumber 1 -Path "C:\ISOs\en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso"
#
######################
#
### After all the VMs have been created and mounted to the appropirate resources,
### it is time to boot them. The .vhd's are pre-installed with Windows Server 2016
### and Windows Server 2019 respectivily.
#
### Starts one VM at a time and configure its network.
Start-VM -VMName $VM1
#
### This removes any media in the dvd-drive.
# Set-VMDvdDrive -VMName $VM1 -ControllerNumber 1 -ControllerLocation 0 -Path $null
#
### Configures the virtual DVD drive at IDE 1,0 of virtual machine TestVM to use no media. 
### (This ejects any existing media from the virtual DVD drive.)
# Set-VMDvdDrive -VMName $VM1,$VM2,$VM3,$VM4 -ControllerNumber 1 -ControllerLocation 0 -Path $null

$vm = "DC2"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
# 

$sb = {
$vm = "DC2"
$cred = Get-Credential -Credential "$vm\Administrator"
Rename-Computer -NewName $vm -Restart
$session = New-PSSession -VMName $vm -Credential $cred
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction Ignore
Remove-PSSession -VMName $vm


$vm = "DC2"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred

$scriptblock = {
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 10.11.12.10 -PrefixLength 24 -DefaultGateway 10.11.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "10.11.12.1,8.8.8.8"
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue


$scriptblock = {Get-WindowsFeature -Name AD*, DNS}
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue | select DisplayName, Name, InstallState 

$install = {Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeAllSubFeature -IncludeManagementTools -Restart}
Invoke-Command -Session $session -ScriptBlock $install -WarningAction SilentlyContinue

$scriptblock = {Get-Command -Module ADDSDeployment}
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue

$sb = {
$dn = "VT17_1"
$cred = Get-Credential "$dn\Administrator"
$session = New-PSSession -VMName $dn -Credential $cred
Install-ADDSDomainController `
-Credential $cred `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath 'C:\Windows\NTDS' `
-DomainName 'VT17_1.local' `
-InstallDns:$true `
-LogPath 'C:\Windows\NTDS' `
-NoRebootOnCompletion:$false `
-SysvolPath 'C:\Windows\SYSVOL' `
-Force:$true
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
# Get-ADComputer -Filter 'Name -like "win-*"' | Remove-ADObject -Recursive -Confirm:$false
Remove-PSSession $vm

$dn = "VT17_1"
$vm = $VM1
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$sb = {shutdown.exe -s -t 0}
Invoke-Command -Session $session -ScriptBlock $sb
Remove-PSSession $vm
#
##################
#
Start-VM -VMName $VM2
#
### This removes any media in the dvd-drive.
# Set-VMDvdDrive -VMName $VM2 -ControllerNumber 1 -ControllerLocation 0 -Path $null
#
### Configures the virtual DVD drive at IDE 1,0 of virtual machine TestVM to use no media. 
### (This ejects any existing media from the virtual DVD drive.)
# Set-VMDvdDrive -VMName $VM1,$VM2,$VM3,$VM4 -ControllerNumber 1 -ControllerLocation 0 -Path $null

$vm = "DC3"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
# 

$sb = {
$vm = "DC3"
$cred = Get-Credential -Credential "$vm\Administrator"
Rename-Computer -NewName $vm -Restart
$session = New-PSSession -VMName $vm -Credential $cred
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction Ignore
Remove-PSSession -VMName $vm


$vm = "DC3"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred

$scriptblock = {
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.11.12.11 -PrefixLength 24 -DefaultGateway 10.11.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "10.11.12.1,8.8.8.8"
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue


$scriptblock = {Get-WindowsFeature -Name AD*, DNS}
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue | select DisplayName, Name, InstallState 

$install = {Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeAllSubFeature -IncludeManagementTools -Restart}
Invoke-Command -Session $session -ScriptBlock $install -WarningAction SilentlyContinue

$scriptblock = {Get-Command -Module ADDSDeployment}
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue

$sb = {
$dn = "VT17_1"
$cred = Get-Credential "$dn\Administrator"
$session = New-PSSession -VMName $dn -Credential $cred
Install-ADDSDomainController `
-Credential $cred `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath 'C:\Windows\NTDS' `
-DomainName 'VT17_1.local' `
-InstallDns:$true `
-LogPath 'C:\Windows\NTDS' `
-NoRebootOnCompletion:$false `
-SysvolPath 'C:\Windows\SYSVOL' `
-Force:$true
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
# Get-ADComputer -Filter 'Name -like "win-*"' | Remove-ADObject -Recursive -Confirm:$false
Remove-PSSession $vm

$dn = "VT17_1"
$vm = $VM2
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$sb = {shutdown.exe -s -t 0}
Invoke-Command -Session $session -ScriptBlock $sb
Remove-PSSession $vm
#
##################
#
Start-VM -VMName $VM3
Set-VMDvdDrive -VMName $VM3 -ControllerNumber 1 -ControllerLocation 0 -Path $null
#
$vm = "SRV1"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
# 
$sb = {
$vm = "SRV1"
$cred = Get-Credential -Credential "$vm\Administrator"
Rename-Computer -NewName $vm -Restart
$session = New-PSSession -VMName $vm -Credential $cred
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction Ignore
Remove-PSSession -VMName $vm


$vm = "SRV1"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred

$scriptblock = {
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 10.11.12.12 -PrefixLength 24 -DefaultGateway 10.11.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "10.11.12.1,8.8.8.8"
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue
Remove-PSSession $vm 

$vm = "SRV1"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$scriptblock = {
$vm = "SRV1"
$cred = Get-Credential -Credential "$vm\Administrator"
Add-Computer -DomainName "VT17_1.local" -Credential $cred -Restart -Force
}
Invoke-Command -Session $session -ScriptBlock $scriptblock
Remove-PSSession $vm

$dn = "VT17_1"
$vm = $VM3
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$sb = {shutdown.exe -s -t 0}
Invoke-Command -Session $session -ScriptBlock $sb
Remove-PSSession $vm
#
##################
#
Start-VM -VMName $VM4
Set-VMDvdDrive -VMName $VM4 -ControllerNumber 1 -ControllerLocation 0 -Path $null
#
$vm = "SRV2"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
# 
$sb = {
$vm = "SRV2"
$cred = Get-Credential -Credential "$vm\Administrator"
Rename-Computer -NewName $vm -Restart
$session = New-PSSession -VMName $vm -Credential $cred
}
Invoke-Command -Session $session -ScriptBlock $sb -ErrorAction SilentlyContinue -WarningAction Ignore
Remove-PSSession -VMName $vm


$vm = "SRV2"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred

$scriptblock = {
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.11.12.13 -PrefixLength 24 -DefaultGateway 10.11.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "10.11.12.1,8.8.8.8"
} 
Invoke-Command -Session $session -ScriptBlock $scriptblock -WarningAction SilentlyContinue
Remove-PSSession $vm 

$vm = "SRV2"
$cred = Get-Credential -Credential "$vm\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$scriptblock = {
$vm = "SRV2"
$cred = Get-Credential -Credential "$vm\Administrator"
Add-Computer -DomainName "VT17_1.local" -Credential $cred -Restart -Force
}
Invoke-Command -Session $session -ScriptBlock $scriptblock
Remove-PSSession $vm

$dn = "VT17_1"
$vm = $VM4
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$sb = {shutdown.exe -s -t 0}
Invoke-Command -Session $session -ScriptBlock $sb
Remove-PSSession $vm
#
##################
#
### OU STRUCTURE
New-ADOrganizationalUnit -Name "Atlantis" -Path "DC=VT17_1,DC=local"
New-ADOrganizationalUnit -Name "Users" -Path "OU=Atlantis,DC=VT17_1,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Atlantis,DC=VT17_1,DC=local"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Atlantis,DC=VT17_1,DC=local"
#
##################
#
# Import active directory module for running AD cmdlets
Import-Module activedirectory
  
#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv C:\CSV-bulk.csv

#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
	#Read user data from each field in each row and assign the data to a variable as below
		
	$Username 	= $User.username
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $User.ou #This field refers to the OU the user account is to be created in

	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 #If user does exist, give a warning
		 Write-Warning "A user account with username $Username already exist in Active Directory."
	}
	else
	{
		#User does not exist then proceed to create the new user account
		
        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@VT17_1.local" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) 
	}
}
#
##################
#
### Shared Folders
Start-VM SRV1

$dn = "VT17_1"
$vm = "SRV1"
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$scriptblock =
{
New-Item "C:\Gemensam" -Type Directory
New-Item "C:\Resurser" -Type Directory
}
Invoke-Command -Session $session -ScriptBlock $scriptblock
Remove-PSSession $vm

$cim = New-CimSession -ComputerName "SRV1"
New-SmbShare -Name "Gemensam" -Path "C:\Gemensam" -CimSession $cim
Revoke-SmbShareAccess -Name Gemensam -AccountName "Everyone" -Force -CimSession $cim
Grant-SmbShareAccess -Name Gemensam -AccountName "Authenticated Users" -AccessRight Change -Force -CimSession $cim

New-SmbShare -Name "Resurser" -Path "C:\Resurser" -CimSession $cim
Revoke-SmbShareAccess -Name Resurser -AccountName "Everyone" -Force -CimSession $cim
Grant-SmbShareAccess -Name Resurser -AccountName "Authenticated Users" -AccessRight Change -Force -CimSession $cim
Remove-CimSession -ComputerName SRV1
#
##################
#
### Create Home Folders & SMB shares

$dn = "VT17_1"
$vm = "SRV1"
$cred = Get-Credential -Credential "$dn\Administrator"
$session = New-PSSession -VMName $vm -Credential $cred
$sb = {New-Item -ItemType Directory -Path C:\Homefolders}
Invoke-Command -Session $session -ScriptBlock $sb
Remove-PSSession $vm

$cim = New-CimSession -ComputerName "SRV1"
New-SmbShare -Name "Homefolders" -Path "C:\Homefolders" -CimSession $cim
Grant-SmbShareAccess -Name Homefolders -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Revoke-SmbShareAccess -Name Homefolders -AccountName "Everyone" -Force -CimSession $cim

 
$users = Import-Csv "C:\CSV-bulk.csv" | select -expand username
ForEach ($u in $users)
{
$name = $u
New-Item -ItemType Directory -Path "\\SRV1\Homefolders\$name"
}


$ADUsers = Import-Csv "C:\CSV-bulk.csv" | select -expand username

ForEach ($ADUser in $ADUsers)  
{ 
 
$cim = New-CimSession -ComputerName SRV1
New-SmbShare -Name "$ADUser" -Path "C:\Homefolders\$ADUser" -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName "Domain Admins" -AccessRight Full -Force -CimSession $cim
Grant-SmbShareAccess -Name $ADUser -AccountName $ADUser -AccessRight Change -Force -CimSession $cim
Revoke-SmbShareAccess -Name $ADUser -AccountName "Everyone" -Force -CimSession $cim
}
#
##################
#