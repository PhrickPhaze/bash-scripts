# Each object is first listed, then for each object, process a division by 10.
10,20,30,40 | ForEach-Object -Process {$_/10}