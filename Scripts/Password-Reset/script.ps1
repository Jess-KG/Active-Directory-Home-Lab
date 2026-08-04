#getting username from the input

$username = Read-Host "Enter the username for password reset"

$User = Get-ADUser -Identity $username

if ($User -eq $null) {
    Write-Host "User not found. Please check the username and try again."
    exit
}

#prompting for new password
$newPassword = Read-Host "Enter the new password" -AsSecureString

#resetting the password
Set-ADAccountPassword -Identity $User -NewPassword $newPassword -Reset

#unlocking the account if it is locked
if ($User.LockedOut) {
    Unlock-ADAccount -Identity $User
    Write-Host "The account has been unlocked."
}

Set-ADUser -Identity $User -ChangePasswordAtLogon $true