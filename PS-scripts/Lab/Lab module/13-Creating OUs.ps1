$OUname = Read-Host "Enter new OU name"
$OUpath = Read-Host "Enter full path to OU"
New-ADOrganizationalUnit -Name $OUname -Path $OUpath
