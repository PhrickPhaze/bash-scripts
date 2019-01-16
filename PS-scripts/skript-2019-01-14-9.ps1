$a = "Total amount of successful login attempts"
$a1 = Get-EventLog -Log Security -EntryType SuccessAudit | where {$_.EventID -eq 4624} | measure

$b = "Total amount of logins via keyboard" 
$b1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 2} | measure

$c = "Total amount of logins via the network" 
$c1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 3} | measure

$d = "Total amount of unlocked logins" 
$d1 = Get-winevent -FilterHashtable @{logname='security'; id=4624} | where {$_.properties[8].value -eq 7} | measure

$e = "Total amount of failed login attempts" 
$e1 = Get-EventLog -Log Security -EntryType FailureAudit | where {$_.EventID -eq 4624} | measure

$a,$a1,$b,$b1,$c,$c1,$d,$d1,$e,$e1 | Out-File -FilePath C:\temp\Logins.txt