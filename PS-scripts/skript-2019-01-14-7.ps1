## A ##

# This command creates a new html file
New-Item -Path C:\temp\fel.html

## THESE ARE THE COMMANDS USED IN THE HTML FORMATTING ##

# COMMENT: This command outputs amount of errors and warnings in the system branch 
# CODE:
# Get-EventLog -Logname system -EntryType Error,Warning | measure

# COMMENT: This command lists the last system event logs from the last 24 hours
# CODE:
# Get-EventLog -LogName System -After (Get-date).AddHours(-24)

# COMMENT: This command lists the last 100 entries in the system logs sorted in a uniquely manner
# CODE:
# Get-EventLog -LogName System -Newest 100 -EntryType Error,Warning | Group-Object EntryType

# COMMENT: This command is split into two parts. The first one is identical to the first command in the script.
#          The second part is an if statement where it'll print out a warning message if the amount exceeds 10 entries.
# CODE:
# $body4 = Get-EventLog -Logname system -EntryType Error,Warning | measure
# If($body4.Count -gt 10) {$outfile = "There are more than 10 warnings/errors!"}

# HTML formatting
$Head = @"
<style>
  body {
    font-family: "Arial";
    font-size: 8pt;
    color: #4C607B;
    }
  th, td { 
    border: 1px solid #e57300;
    border-collapse: collapse;
    padding: 5px;
    }
  th {
    font-size: 1.2em;
    text-align: left;
    background-color: #003366;
    color: #ffffff;
    }
  td {
    color: #000000;
    }
  .even { background-color: #ffffff; }
  .odd { background-color: #bfbfbf; }
</style>
  
"@
# Inserting the commands above in HTML and out it to the HTML file created in the begenning of the script
[string]$body1 = Get-EventLog -Logname system -Entrytype Error,Warning | measure | ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>Amount of errors and warnings</h4></font>" | Out-File -FilePath C:\temp\fel.html
[string]$body2 = Get-EventLog -LogName System -After (Get-date).AddHours(-24)| ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>Last 24 hours report</h4></font>" | Out-File -FilePath C:\temp\fel.html -Append
[string]$body3 = Get-EventLog -LogName System -Newest 100 -EntryType Error,Warning | Group-Object EntryType | ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>Sort objects uniquely</h4></font>" | Out-File -FilePath C:\temp\fel.html -Append
$body4 = Get-EventLog -Logname system -EntryType Error,Warning | measure
If($body4.Count -gt 10) {$outfile = "There are more than 10 warnings/errors!"}
ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>If statement <br><br>$outfile</h4></font>" | Out-File -FilePath C:\temp\fel.html -Append

 

# Running the script up until now implements all commands (in the 'a' assignment) to single html file with every output.


## B ##

$date = Get-Date -UFormat "%Y-%m-%d"
New-Item -Path C:\temp\kommandon-$date.html

# HTML formatting
$Head = @"
<style>
  body {
    font-family: "Arial";
    font-size: 8pt;
    color: #4C607B;
    }
  th, td { 
    border: 1px solid #e57300;
    border-collapse: collapse;
    padding: 5px;
    }
  th {
    font-size: 1.2em;
    text-align: left;
    background-color: #003366;
    color: #ffffff;
    }
  td {
    color: #000000;
    }
  .even { background-color: #ffffff; }
  .odd { background-color: #bfbfbf; }
</style>
  
"@

[string]$body = $cmdlets = Get-History | Sort-Object -Unique | ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>Command history</h4></font>" | Out-File -FilePath C:\temp\kommandon-2019-01-15.html

# $cmdlets = Get-History | Sort-Object -Unique
# $cmdlets

# COMMENT: Command to list all commands into a .txt file with the $date variable in the file name
# CODE: 
# Get-History | Sort-Object -Unique | Out-File -FilePath C:\temp\$date-kommandon.txt

# The following bit of code ejects the CD Unit, and if it fails it uses SAPI.SPVoice to broadcast an error message
[CmdletBinding()] 
$text = "Failed to operate the disk. Details : I/O unit does not exist"
param( 
[switch]$Eject, 
[switch]$Close 
) 
try { 
    $Diskmaster = New-Object -ComObject SAPI.SPVoice
    $DiskRecorder = New-Object -ComObject SAPI.SPVoice 
    $DiskRecorder.InitializeDiscRecorder($DiskMaster) 
    if ($Eject) { 
        $DiskRecorder.EjectMedia() 
    } elseif($Close) { 
        $DiskRecorder.EjectMedia() 
    } 
} catch { 
    (New-Object –ComObject SAPI.SPVoice).Speak(“$text”)
} 

## C ##

# This piece of code sends output to email
# $text1 = 'Failed to operate the disk. Details : I/O unit does not exist'
# $email = @{
# From = "daniel.haque2@yh.nackademin.se"
# To = "mats.karlsson@nackademin.se"
# Subject = "Powershell"
# SMTPServer = "mail.ownit.nu"
# Body = $text1
# }
# 
# send-mailmessage @email