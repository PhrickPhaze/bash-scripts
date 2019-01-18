## This creates the .csv files to use in the lab. It's commented out because it 
## appends the values each time its executed.

# Add-Content -Path C:\csv-example.csv -Value 'Element,Symbol,Protons,Neutrons'
# 
# $table = @(
# 'Iron,Fe,26,30'
# 'Oxygen,O,8,8'
# 'Hydrogen,H,1,0'
# 'Carbon,C,6,6'
# )
# $table | foreach { Add-Content -Path  C:\csv-example.csv -Value $_ }

# This code imports the .csv file and averages out the amount of protons for each element.
$elements = Import-Csv C:\csv-example.csv
$elements.Protons | Measure-Object -Average | Select-Object -Property Average

# This piece of code tests if protons are equal to neutrons and then prints out the symbols 
# for each matched element.
$file = Get-Content C:\csv-example.csv

for ($count = 1; $count -lt $file.Length; $count++)
    {
    $protons = ([string]$file[$count]).Split(',')[2]
    $neutrons = ([string]$file[$count]).Split(',')[3]
    $symbols = ([string]$file[$count]).Split(',')[1]

    if ($protons -eq $neutrons)
    { $symbols } # Closes 'if'

} # Closes 'for'



