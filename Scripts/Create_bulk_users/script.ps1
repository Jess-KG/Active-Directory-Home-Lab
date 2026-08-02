Import-Csv users.csv | ForEach-Object {
    $FirstName = $_.FirstName
    $LastName = $_.LastName
    $OU = $_.Department
    $Username = ($FirstName.Substring(0,1)+$LastName).ToLower()

    $TempPassword = ConvertTo-SecureString "Temp123!"-AsPlainText -Force

    New-ADUser `
        -Name "$FirstName $LastName" `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $Username `
        -AccountPassword $TempPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true `
        -Path "OU=$OU,OU=Company,DC=lab,DC=local"
}

Write-Host "Bulk user accounts successfully created."