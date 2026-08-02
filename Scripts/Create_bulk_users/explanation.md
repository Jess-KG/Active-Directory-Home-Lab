This script reads `users.csv` and creates an Active Directory account for each row.

For every user record, it:
- extracts first name, last name, and department,
- builds a username from the first initial plus last name,
- sets a temporary password (`Temp123!`), and
- creates a new AD user in the OU for that department under `OU=Company,DC=lab,DC=local`.

Each account is enabled immediately and forced to change the password at the first logon.
