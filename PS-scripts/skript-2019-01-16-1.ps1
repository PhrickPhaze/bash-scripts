## These cmdlets determines what version of PowerShell you are using,
## if you run anything below PowerShell 5.0 you need to run the second cmdlet.
## If you don't have the RSAT features, use the third and last cmdlet to add them
# $PSVersionTable.PSVersion
# Install-Module xActiveDirectory
# Get-WindowsCapability -Name RSAT* -online | Add-WindowsCapability -Online

## Exploring A Domain With PowerShell
Get-ADDomain
Get-Command -Verb Get -Module ActiveDirectory
Get-ADUser -Filter 'SamAccountName -eq "Administrator"' -Properties *
Get-ADUser Administrator
# Get-ADComputer $env:COMPUTERNAME | Get-ADPrincipalGroupMembership
Get-ADUser Administrator -Properties Memberof

## Creating And Working With Users
New-ADUser
"Assassins", "Templars", "Masyaf", "Firenze", "ModernAge" | ForEach-Object {New-ADGroup -Name $_ -GroupScope Global}
$names = "Altaïr Ibn La'Ahad", "Ezio Auditore da Firenze"
$departments = "Syria", "Firenze", "Assassins"

ForEach($name in $names) {
    ForEach($department in $departments) {
        $username = "{0}{1}" -f $name.substring(0,1), $name.split()[1]

        $user = New-ADUser -GiveName $name.split()[0] `
                           -Surname $name.split()[1] `
                           -Name "$Name$department" `
                           -AccountPassword (ConvertTo-SecureString -String "changeme1!" -AsPlainText -Force) `
                           -Department $department `
                           -UserPrincipleName "$username$department@VT17_1.local" `
                           -PassThru

        Get-ADGroup -Filter 'name -like "Assassins"' | Add-ADGroupMember -Members $user
    }
}
Set-ADUser
Get-ADuser -Filter '(surname -eq "Altaïr") -or (surname -eq "Ezio")' | Set-ADUser -Enabled $true
Get-ADGroupMember -Identity Assasins | Format-Table Name,SamAccountName
Disable-ADAccount -Identity ModernAge
Get-ADUser ModernAge | Format-Table SAMAccountName,Enabled
Get-ADUser -Filter 'department -eq "Templars"' | Disable-ADAccount
Get-ADUser -Filter 'department -eq "Templars"' | Format-Table SAMAccountName,Enabled
Remove-ADUser
Remove-ADUser"AIbn La'ahad"
Enable-ADAccount
Enable-ADAccount"EAuditore da Firenze"
Remove-ADGroupMember -Identity testAssassins -Members "AIbn La'ahad"
$members = Get-ADUser -Filter 'department -eq "templars" -or department -eq "Assassins"'
Remove-ADGroupMember -Identity testAssassins -Members $members
Get-Help Remove-ADGroupMember -Parameter members
Get-ADPrincipalGroupMembership
Get-ADPrincipalGroupMembership -Identity "AIbn La'ahad"
Get-ADUser -Filter 'givenname -eq "Altaïr" or givenname -eq "Ezio"' | Get-ADPrincipalGroupMembership | Format-Table name,SAMAccountName
$reportData = ForEach($group in (Get-ADGroup -filter 'name -like "test*"')) {
                ForEach($member in (Get-ADGroupMember $group)) {
                    New-Object -TypeName PSobject -Property @{group=$group.Name;member=$member.name}
                }
              }
$reportData | Out-GridView -Title MembershipReport