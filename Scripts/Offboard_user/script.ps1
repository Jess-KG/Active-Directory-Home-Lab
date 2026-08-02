#Offboarding an employee

Import-Module ActiveDirectory

$SamAccountName = Read-Host "Enter the SamAccountName of the user to offboard"

$User = Get-ADUser -Identity $SamAccountName

if ($User -eq $null) {
    Write-Host "User not found. Please check the SamAccountName and try again."
    exit
}

Disable-ADAccount -Identity $User 

#remove user from all groups
$Groups = Get-ADPrincipalGroupMembership -Identity $User

foreach ($Group in $Groups) {
    if ($Group.Name -ne "Domain Users") { #because we don't want to remove the user from Domain Users group
        Remove-ADGroupMember `
        -Identity $Group `
        -Members $User `
        -Confirm:$false
    }
}

#Move to Disabled Users OU

Move-ADObject `
    -Identity $User.DistinguishedName `
    -TargetPath "OU=Disabled-Users,OU=Company,DC=lab,DC=local"

Write-Host "User $SamAccountName has been offboarded successfully."