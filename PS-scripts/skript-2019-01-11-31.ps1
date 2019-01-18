# Writes 'Hello world!' to the host prompt
Write-Host "Hello world!"

# Writes 'Hello world!' with yellow text to the host prompt
Write-Host -ForegroundColor Yellow "Hello world!"

# Writes 'Hello world!' with a yellow background to the host prompt
Write-Host -BackgroundColor Yellow "Hello world!"

# Opens up a web browser with the documentation of how to use the 'Clear-host' cmdlet
help Clear-Host -online