# Sets the array for the different objects
$Greenstuffs = "Gurka","Tomat","Majs","Avokado","Morot","Majs","Morot"

# Creates a new file to store the objects unto
New-Item -Path C:\temp\gronsaker.txt -ItemType File

# Adds the objects to the file
Add-Content -Path C:\temp\gronsaker.txt -Value "$Greenstuffs"

# Prints the array of objects
$Greenstuffs

# Stores a filtered version of the array
$gr = $Greenstuffs | Sort-Object -Unique

# Prints the filtered array
$gr

# Prints the number of objects in the array
$Greenstuffs | measure