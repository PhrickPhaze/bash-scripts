# Assigns $a to the value of 3, writes it out to host and determines what type of value it is.
$a = 3
Write-Host "$a"
$a.GetType()

# Assigns $b to the value of 3.3, writes it out to host and determines what type of value it is.
$b = 3.3
Write-Host "$b"
$b.GetType()

# Assigns $c to the value of "3.3", writes it out to host and determines what type of value it is.
$c = "3.3"
Write-Host "$c"
$c.GetType()

# Assigns $d to the value of $a + $b , writes it out to host and determines what type of value it is
$d = $a+$b
Write-Host "$d"
$d.GetType()

# Assigns $e to the value of 3.4, $f to the value of 3.6 and $g to the value of $e + $f,
# writes it out to host and determines what type of value $e, $f and $g are respectivily.
$e = 3.4
$f = 3.6
$g = $e+$f
$e.GetType()
$f.GetType()
$g.GetType()