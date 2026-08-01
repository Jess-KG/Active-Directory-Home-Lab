# Active Directory User Account Enablement & Password Reset Automation (PowerShell)

## Overview

This project demonstrates how PowerShell can be used to automate common Active Directory administration tasks.

In a real enterprise environment, IT administrators regularly handle user account management tasks such as enabling accounts, resetting passwords, and enforcing password changes. Performing these actions manually for hundreds of users is time-consuming and increases the chance of errors.

This script automates the process of identifying disabled Active Directory user accounts, enabling them, assigning temporary passwords, and forcing users to change their password during their next login.

---

## Problem Scenario

During user onboarding or account recovery, administrators may need to:

* Enable disabled user accounts
* Assign temporary passwords
* Require users to create a new password at first login

Manually completing these steps for every account is inefficient.

This script provides a simple automation solution.

---

## Script Objectives

The script performs the following actions:

1. Imports the Active Directory PowerShell module
2. Finds all disabled user accounts
3. Enables each disabled account
4. Resets the account password to a temporary password
5. Forces users to change their password at their next login

---

## Technologies Used

* Windows Server Active Directory
* PowerShell
* Active Directory PowerShell Module

---

## Script Workflow

```
Start
 |
 |-- Import Active Directory Module
 |
 |-- Create Temporary Password
 |
 |-- Search for Disabled Users
 |
 |-- For Each Disabled User:
 |       |
 |       |-- Enable Account
 |       |
 |       |-- Reset Password
 |       |
 |       |-- Force Password Change
 |
End
```

---

## PowerShell Script

```powershell
Import-Module ActiveDirectory

# Temporary password for all accounts
$TempPassword = ConvertTo-SecureString "TempPass123!" -AsPlainText -Force

# Retrieve disabled Active Directory users
$DisabledUsers = Get-ADUser -Filter {Enabled -eq $false}

foreach ($User in $DisabledUsers) {

    Write-Host "Processing user:" $User.SamAccountName

    # Enable user account
    Enable-ADAccount -Identity $User.SamAccountName

    # Reset user password
    Set-ADAccountPassword `
        -Identity $User.SamAccountName `
        -Reset `
        -NewPassword $TempPassword

    # Require password change during next login
    Set-ADUser `
        -Identity $User.SamAccountName `
        -ChangePasswordAtLogon $true
}

Write-Host "All disabled accounts have been enabled and passwords reset."
```

---

## Script Explanation

### Import Active Directory Module

```powershell
Import-Module ActiveDirectory
```

Loads the Active Directory cmdlets required to manage users.

Examples:

* `Get-ADUser`
* `Enable-ADAccount`
* `Set-ADAccountPassword`
* `Set-ADUser`

---

### Retrieve Disabled Users

```powershell
Get-ADUser -Filter {Enabled -eq $false}
```

Searches Active Directory and returns accounts where:

```
Enabled = False
```

These accounts are stored in the `$DisabledUsers` variable.

---

### Enable Accounts

```powershell
Enable-ADAccount
```

Changes the account state from:

```
Disabled
    ↓
Enabled
```

allowing the user to authenticate.

---

### Reset Password

```powershell
Set-ADAccountPassword
```

Assigns a temporary password to the account.

---

### Force Password Change

```powershell
-ChangePasswordAtLogon $true
```

Ensures the user creates their own password after signing in.

---

## Example Use Case

Scenario:

A company has multiple disabled accounts after a migration.

Instead of manually:

* Opening Active Directory Users and Computers
* Finding each account
* Enabling users
* Resetting passwords

An administrator can run this script and complete the process automatically.

---

## Improvements for Future Versions

Possible enhancements:

* Generate unique random passwords for each user
* Export results to a CSV report
* Add logging of successful and failed operations
* Read users from a CSV onboarding file
* Send notification emails to users
* Add error handling with `try/catch`

---

## Skills Demonstrated

* Active Directory administration
* PowerShell scripting
* User lifecycle management
* Identity and Access Management (IAM)
* Automation of IT operations

---

## Lab Environment

This project was tested in a virtual Active Directory lab environment using:

* Windows Server Domain Controller
* Windows Client machine
* Active Directory Domain Services
* PowerShell automation
