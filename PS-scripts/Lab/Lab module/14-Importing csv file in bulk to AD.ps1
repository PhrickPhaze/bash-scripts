# Imports the AD module for PowerShell
Import-Module activedirectory

# Variables
$OUpath = Read-Host "Enter OU path to store users"
$CSVpath = Read-Host "Enter .csv path"  

# Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv $CSVpath

# Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
    
    	

    # Read user data from each field in each row and assign the data to a variable as below
		
	$Username 	= $User.username
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $OUpath #This field refers to the OU the user account is to be created in

	# Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 # If user does exist, give a warning
		 Write-Warning "A user account with username $Username already exist in Active Directory."
	}
	else
	{
		# User does not exist then proceed to create the new user account
		
        # Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$domain" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) 
	}
}
