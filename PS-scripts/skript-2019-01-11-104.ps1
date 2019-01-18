# These variables sets the dates for each person.
[datetime] $jo="15 april 1994"
[datetime] $alex="27 november 1993"
[datetime] $sofia="22 june 1994"
[datetime] $danny="23 november 1991"

# The user is asked to type in their name.
$name = Read-Host "What is your name? (Jo, Alex, Sofia, Danny)? "
# Depending on what name they input, their birthday is shown. Wrong names aren't allowed.
if ($name -eq "Jo") {"Hi $name. Your birthday is: $jo"}
    Elseif ($name -eq "Alex") {"Hi $name. Your birthday is: $alex"}
    Elseif ($name -eq "Sofia") {"Hi $name. Your birthday is: $sofia"}
    Elseif ($name -eq "Danny") {"Hi $name. Your birthday is: $danny"}
else {"Wrong name"}

