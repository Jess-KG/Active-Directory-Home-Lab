#Print out list of users that are currently locked out

Import-Module ActiveDirectory

$LockedOutUsers = Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut

if ($LockedOutUsers) {
    Write-Host "Currently Locked Out Users:"
    foreach ($user in $LockedOutUsers) {
        Write-Host $user.SamAccountName
    }
} else {
    Write-Host "No users are currently locked out."
}