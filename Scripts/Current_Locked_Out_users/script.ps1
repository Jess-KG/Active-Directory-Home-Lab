#Print out list of users that are currently locked out

Import-Module ActiveDirectory

$LockedOutUsers = Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut

if ($LockedOutUsers) {
    Write-Host "Currently Locked Out Users:"
    foreach ($user in $LockedOutUsers) {
        Write-Host $user.SamAccountName

        #last logon time
        $lastLogon = $user.LastLogonDate
        if ($lastLogon) {
            Write-Host "Last Logon Time: $lastLogon"
        } else {
            Write-Host "Last Logon Time: Not Available"
        }
    }
} else {
    Write-Host "No users are currently locked out."
}