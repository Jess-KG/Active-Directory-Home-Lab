Import-Module ActiveDirectory

$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"

#Username is first letter of first name + last name
$Username = ($FirstName.Substring(0,1)+$LastName).ToLower()

$TempPassword = ConvertTo-SecureString "Temp123!"-AsPlainText -Force

$Organization = Read-Host "Enter Organization"

New-ADUser `
    -Name "$FirstName $LastName" `
    -GivenName $FirstName `
    -Surname $LastName `
    -SamAccountName $Username `
    -AccountPassword $TempPassword `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -Path "OU=$Organization,OU=Company,DC=lab,DC=local"

Write-Host "Account successfully created."
