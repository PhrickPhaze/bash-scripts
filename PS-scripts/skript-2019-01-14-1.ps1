# Moves the current position to the C:\
cd C:\

# Creates the temp directory
New-Item -Path C:\temp -ItemType Directory

# Creates the test.txt file
New-Item -Path C:\temp\test.txt -ItemType File

# Sets the date variable and its format
$Date = Get-Date -uformat "%Y-%m-%d"

# Adds the date as content to the file
Add-Content -Path "C:\temp\test.txt" -Value "$date"

# Adds 'Välkommen till Nackademin' to the file
Add-Content -Path "C:\temp\test.txt" -Value "Välkommen till Nackademin"

# Removes all content from the file
Clear-Content -Path C:\temp\test.txt

# Adds the previous content in alternative order
Add-Content -Path "C:\temp\test.txt" -Value "Välkommen till Nackademin"
Add-Content -Path "C:\temp\test.txt" -Value "$date"
