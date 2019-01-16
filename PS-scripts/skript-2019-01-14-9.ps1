# The first line of code sets a variable for each operation the code below prints out of what it measures.
# The second line of code is the actual operation and prints the result.


# This code measures the amount of successful login attempts have been made.
$a = "Total amount of successful login attempts"
$a1 = Get-EventLog -Log Security -EntryType SuccessAudit | where {$_.EventID -eq 4624} | measure

# This code measures how many login attempts have been made via a keyboard.
$b = "Total amount of logins via keyboard" 
$b1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 2} | measure

# This code measures how many login attempts have been made via the network.
$c = "Total amount of logins via the network" 
$c1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 3} | measure

# This code measures how many unlocked login attempts have been made.
$d = "Total amount of unlocked logins" 
$d1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 7} | measure

# This code measures how many failed login attempts have been made.
$e = "Total amount of failed login attempts" 
$e1 = Get-EventLog -Log Security -EntryType FailureAudit | where {$_.EventID -eq 4624} | measure

# This code prints out all operations to a single .txt file
$a,$a1,$b,$b1,$c,$c1,$d,$d1,$e,$e1 | Out-File -FilePath C:\temp\Logins.txt