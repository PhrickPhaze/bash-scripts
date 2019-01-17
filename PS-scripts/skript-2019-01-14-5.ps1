# The where command tests the field defined by the field name to a property below said field
Get-Service | where Status -eq "Running"