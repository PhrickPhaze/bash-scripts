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
# Get-EventLog -LogName System -Newest 100 | Sort-Object -Unique

# COMMENT: This command is split into two parts. The first one is identical to the first command in the script.
#          The second part is an if statement where it'll print out a warning message if the amount exceeds 10 entries.
# CODE:
# Get-EventLog -Logname system -EntryType Error,Warning | measure
# If($test.Count -gt "10") {Write-Host "There are more than 10 warnings/errors!"}

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
[string]$body3 = Get-EventLog -LogName System -Newest 100 | Sort-Object -Unique | ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>Sort objects uniquely</h4></font>" | Out-File -FilePath C:\temp\fel.html -Append
[string]$body3 = Get-EventLog -Logname system -EntryType Error,Warning | measure
If($test.Count -gt "10") {Write-Host "There are more than 10 warnings/errors!"}
ConvertTo-HTML -head $Head -Body "<font color=`"Black`"><h4>If statement</h4></font>" | Out-File -FilePath C:\temp\fel.html -Append

# Running the whole script implements all commands to single html file with every output.