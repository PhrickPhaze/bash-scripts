# Sets the variable for my birthday and the statistics of my age.
[datetime] $danny = "23 november 1991"
$born = ((get-date)-$danny)

# Determines if I have lived for more or less than a million seconds.
if ($born.TotalSeconds -gt 1000000) {"I have lived for more than a million seconds!"}
else {"I have not lived more than a million seconds..."}

# Determines if I have lived for more or less than a million minutes.
if ($born.TotalMinutes -gt 1000000) {"I have lived for more than a million minutes!"}
else {"I have not lived more than a million minutes..."}

# Determines if I have lived for more or less than a million hours.
if ($born.TotalHours -gt 1000000) {"I have lived for more than a million hours!"}
else {"I have not lived more than a million hours..."}

# Writes out m ages in unites of million of minutes.
$millionminutes = $born.TotalMinutes / 1000000
Write-host "I have lived for $millionminutes million minutes!"