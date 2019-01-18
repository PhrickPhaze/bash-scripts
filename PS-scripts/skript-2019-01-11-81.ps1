# Get the contents from the file address.txt
Get-Content C:\address.txt

# Assign the contents of address.txt to $address and print the variable
$address = Get-Content C:\address.txt
$address

# Create a multi-line value and store it in $workaddress and print it
$workadress = "Eugeniavägen 3`n171 64`nSolna"
$workadress

# Store my name to a variable and pipe it to get-member
$myname = "Danny TAEMN"
$myname | Get-Member

# The String.Substring syntax below prints the $myname varible in all 
# upper case letters or all lower case letters respectivily.
$myname.ToUpper()
$myname.ToLower()