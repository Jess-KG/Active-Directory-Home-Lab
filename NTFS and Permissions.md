# Active Directory File Server, Permissions & PowerShell Automation Lab

## Overview

This project involved building and managing a small enterprise-style Windows domain environment using Active Directory Domain Services (AD DS), Windows File Server features, Group Policy, and PowerShell automation.

The goal of the lab was to understand how organisations manage user identities, control access to resources, and automate common IT administration tasks.

The lab simulated a company environment where different departments require controlled access to shared resources.

---

# Lab Objectives

The main objectives of this lab were:

* Manage users and groups in Active Directory
* Understand identity and access management concepts
* Configure departmental file shares
* Implement NTFS and share permissions
* Troubleshoot access issues
* Automate user administration using PowerShell
* Introduce Group Policy-based management

---

# Environment

## Infrastructure

* Windows Server Domain Controller
* Windows Client Machine
* Active Directory Domain Services
* PowerShell Active Directory Module
* SMB File Sharing

Example domain structure:

```
northwind.local

├── Users
├── Groups
├── Computers
└── Organizational Units
```

---

# 1. Active Directory User Management

Active Directory was used to manage user identities within the domain.

Tasks completed:

* Created user accounts
* Enabled user accounts
* Assigned passwords
* Managed account states

User lifecycle management was explored:

```
Create User
      |
      ↓
Enable Account
      |
      ↓
Assign Permissions
      |
      ↓
User Access
      |
      ↓
Disable Account (Offboarding)
```

A key concept learned was that user accounts and permissions are separate processes. Creating a user does not automatically provide access to company resources.

---

# 2. PowerShell Active Directory Automation

A PowerShell script was created to automate the process of enabling disabled accounts and resetting passwords.

## Purpose

In enterprise environments, administrators may need to enable many accounts after onboarding, migrations, or account recovery.

Manually completing these tasks for every user is inefficient.

The script automates:

* Finding disabled users
* Enabling accounts
* Resetting passwords
* Requiring password changes during first login

## Workflow

```
Start

 ↓

Import Active Directory Module

 ↓

Find Disabled Users

 ↓

For Each User:

    Enable Account

    Reset Password

    Force Password Change

 ↓

Complete
```

---

# 3. Active Directory Security Groups

Security groups were used to manage permissions instead of assigning permissions directly to individual users.

Example:

Incorrect approach:

```
Finance Folder

Benjamin Carter → Modify
```

Better approach:

```
Finance Folder

Finance_GG
     |
     |
Benjamin Carter
```

Benefits:

* Easier administration
* Better scalability
* Reduced permission errors
* Follows enterprise security practices

---

# 4. File Server Structure

A departmental file server was created to simulate a company environment.

Folder structure:

```
CompanyData

├── Finance
├── HR
├── IT
└── Sales
```

Each department received its own folder with controlled access.

---

# 5. SMB File Sharing

Windows Server file sharing was configured using SMB.

The difference between local and network paths was explored.

Local path:

```
C:\CompanyData\Finance
```

Network path:

```
\\DC01\Finance
```

The network share acts as an access point to the existing folder rather than creating a duplicate copy.

---

# 6. NTFS Permissions

NTFS permissions were configured to control what users could do inside folders.

Example:

```
Finance Folder

Finance_GG
    Modify
```

Users inside Finance_GG could:

* Create files
* Modify files
* Delete files

Permissions were assigned to groups rather than individual users.

---

# 7. Share Permissions vs NTFS Permissions

Two layers of permissions were explored.

## Share Permissions

Controls access to the network share.

Example:

```
\\DC01\Finance
```

## NTFS Permissions

Controls access inside the folder.

Example:

```
Finance Folder
```

Effective permissions are determined by both:

```
Share Permissions
        +
NTFS Permissions
        =
Final Access Result
```

---

# 8. Access Troubleshooting Scenario

A simulated support ticket was created:

> "Benjamin Carter cannot access the Finance folder."

Troubleshooting process:

## Step 1: Verify Group Membership

Checked whether Benjamin belonged to:

```
Finance_GG
```

---

## Step 2: Verify Folder Permissions

Confirmed:

```
Finance_GG

↓

Finance Folder

↓

Modify Permission
```

---

## Step 3: Refresh User Authentication Token

After adding a user to a security group, the current login session does not automatically update.

The solution:

```
Sign out

↓

Sign back in

↓

New security token generated

↓

New permissions applied
```

This demonstrated a real-world Active Directory troubleshooting scenario.

---

# 9. Group Policy Introduction

Group Policy was introduced to centrally manage Windows settings.

Instead of manually configuring every computer:

```
Computer 1
Computer 2
Computer 3
```

Administrators can apply policies centrally:

```
Group Policy

        ↓

Domain Computers / Users

        ↓

Automatic Configuration
```

Initial GPO work included:

* Creating policies
* Linking policies to OUs
* Preparing drive mapping policies

---

# 10. Network Drive Mapping

The concept of automatically mapping departmental drives through Group Policy was explored.

Manual method:

```
User opens:

\\DC01\Finance
```

Enterprise method:

```
User Login

     ↓

Group Policy Applies

     ↓

F: Finance Drive Appears
```

This reduces user effort and improves consistency.

---

# Skills Demonstrated

## Technical Skills

* Active Directory Administration
* Windows Server Management
* PowerShell Automation
* SMB File Sharing
* NTFS Permissions
* Group Policy Management
* Identity and Access Management (IAM)

## Troubleshooting Skills

* User access troubleshooting
* Permission analysis
* Authentication token troubleshooting
* Group membership verification

---

# Future Improvements

Possible future enhancements:

* Implement DHCP and DNS services
* Create automated user onboarding scripts
* Add PowerShell logging
* Generate permission audit reports
* Implement security auditing
* Integrate SIEM monitoring concepts

---

# Key Takeaway

This lab demonstrated how enterprise environments manage users, permissions, and resources.

The main concepts learned were:

* Users are managed through Active Directory
* Permissions should be assigned through groups
* File access requires correct identity and permissions
* PowerShell can automate administration tasks
* Group Policy enables centralized management

This project represents a foundation for Windows System Administration, Identity and Access Management (IAM), and Security Operations workflows.
