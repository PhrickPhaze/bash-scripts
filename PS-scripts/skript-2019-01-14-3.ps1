# Create a new file
New-Item -Path C:\temp\test2.txt -ItemType File

#Set the time variable
$time = Get-Date -UFormat "%H:%M:%S"

# Add the time variable in the file as content
Add-Content -Path C:\temp\test2.txt -Value "$time"

# Add more content to the file
Add-content -Path C:\temp\test2.txt -Value "Välkommen hem"

# Compare test.txt with test2.txt
Compare-Object -ReferenceObject $(Get-Content C:\temp\test.txt) -DifferenceObject $(Get-content C:\temp\test2.txt)
 