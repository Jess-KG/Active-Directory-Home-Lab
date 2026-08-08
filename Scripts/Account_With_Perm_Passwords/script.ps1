#generating a report of all accounts with passwords set to never expire

Import-Module ActiveDirectory

$accounts = Get-ADUser -Filter * -Properties PasswordNeverExpires | Where-Object { $_.PasswordNeverExpires -eq $true }

$report = Foreach ($account in $accounts) {
    [PSCustomObject]@{
       Name            = $acct.Name
        SamAccountName  = $acct.SamAccountName
        Enabled         = $acct.Enabled
        PasswordLastSet = $acct.PasswordLastSet
        LastLogonDate   = $acct.LastLogonDate
        Description     = $acct.Description
    }
}

$report | Export-Csv -Path "C:\Reports\AccountsWithNeverExpirePasswords.csv" -NoTypeInformation