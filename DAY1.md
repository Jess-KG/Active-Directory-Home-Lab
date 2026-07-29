# Active-Directory-Home-Lab
# Active Directory Home Lab - Day 1: Domain Setup, Users, Permissions and Group Policy

## Overview

Today I completed the initial setup of an Active Directory home lab environment using a Windows Server Domain Controller and a Windows 11 client machine.

The goal of this lab is to simulate a small enterprise environment and practice common tasks performed by IT Helpdesk, System Administrators, and Cybersecurity professionals.

## Lab Environment

### Virtual Machines

| Machine    | Role                             |
| ---------- | -------------------------------- |
| DC01       | Windows Server Domain Controller |
| WINCLIENT1 | Windows 11 Domain Client         |

### Services Configured

* Active Directory Domain Services (AD DS)
* Domain Controller
* DNS
* Domain-joined Windows client
* Group Policy Management
* File sharing and NTFS permissions

---

# 1. Active Directory Domain Setup

A Windows Server machine was configured as the Domain Controller.

The following components were configured:

* Installed Active Directory Domain Services role
* Promoted the server to a Domain Controller
* Created an Active Directory domain
* Configured DNS during domain promotion

The Domain Controller became responsible for:

* User authentication
* Directory management
* Group Policy processing
* Domain-wide security controls

---

# 2. Windows 11 Client Domain Join

A Windows 11 client virtual machine was connected to the Active Directory domain.

After joining the domain:

* The client was able to authenticate using domain credentials
* Network communication between the client and Domain Controller was verified
* Domain authentication was tested successfully

This confirmed that:

* DNS resolution was working
* The client could locate the Domain Controller
* Kerberos authentication was functioning

---

# 3. Active Directory Organizational Unit (OU) Structure

Organizational Units were created to organise objects and prepare the environment for Group Policy management.

Current OU structure:

```
LAB.LOCAL

Company
│
├── Users
│   ├── Employees
│   └── Admins
│
└── Computers
    ├── Workstations
    └── Servers
```

OUs will later be used to apply different security policies and administrative controls.

Example:

* Workstations OU → endpoint security policies
* Admins OU → stricter administrative policies

---

# 4. User Account Management

Created test user accounts for the domain environment.

Users were organised according to their roles.

Example:

```
Users
│
├── Employees
│   └── Jess
│
└── Admins
    └── John
```

Configured:

* User accounts
* Password settings
* Administrative privileges where required

Understanding user lifecycle management is essential for Helpdesk and System Administration roles.

---

# 5. Shared Folder and NTFS Permissions

Created a shared folder structure to simulate company resources.

Structure:

```
CompanyData

├── Finance
│
└── IT
```

Configured access permissions using Windows file permissions.

Initial testing was performed using different user accounts to understand:

* Share permissions
* NTFS permissions
* Permission inheritance
* Effective access

Key learning:

Permissions should be assigned to groups rather than individual users to improve scalability and security.

---

# 6. Security Groups Introduction

Created security groups to prepare for role-based access control (RBAC).

Current groups:

```
Groups

├── Finance_Users
│
└── IT_Users
```

The purpose of groups is to control access to resources.

Example:

```
Jess
 |
 ↓
Finance_Users
 |
 ↓
Finance Folder
 |
 ↓
Modify Access
```

This follows the principle of assigning permissions based on roles rather than individual accounts.

---

# 7. Group Policy Configuration

Configured basic Group Policy settings.

## Password Policy

Configured domain password requirements:

* Minimum password length
* Password complexity
* Password history

Purpose:

To enforce secure authentication practices across the domain.

---

## Account Lockout Policy

Configured account lockout settings to protect against brute-force attacks.

Purpose:

* Prevent repeated password guessing attempts
* Reduce risk of compromised accounts

---

## Workstation Security Hardening

Created a workstation security GPO.

Implemented security controls such as:

* Restricting removable storage access

Purpose:

To simulate endpoint hardening practices used in enterprise environments.

---

# 8. Authentication and Kerberos Observation

During authentication testing, Windows Security logs showed successful domain authentication events involving Kerberos.

Key concepts observed:

* Domain authentication
* Kerberos ticket-based authentication
* Domain Controller authentication process

Authentication flow:

```
User Login

     ↓

Domain Controller

     ↓

Kerberos Authentication

     ↓

Access Granted
```

This provided practical exposure to how Active Directory authentication works internally.

---

# Key Learning Outcomes

By completing this stage of the lab, I gained practical experience with:

* Building an Active Directory environment
* Managing domain users
* Designing OU structures
* Configuring security groups
* Applying Group Policies
* Managing file permissions
* Understanding RBAC principles
* Observing Kerberos authentication
* Troubleshooting domain connectivity

---

# Next Steps

Future improvements to this lab will include:

* Expanding user and group structures
* Implementing realistic department-based access control
* Creating Helpdesk troubleshooting scenarios
* Practicing user lifecycle management
* Learning DNS and DHCP administration
* Exploring Active Directory security monitoring
* Simulating common enterprise support tickets
