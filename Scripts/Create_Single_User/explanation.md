This script creates one Active Directory user account from input provided at the prompt.

It:
- asks for first and last name,
- creates a username from the first initial and last name,
- uses a fixed temporary password (`Temp123!`),
- asks for the target OU/organization,
- creates the AD user under `OU=<Organization>,OU=Company,DC=lab,DC=local`, and
- enables the account while requiring a password change at the next logon.

Finally, it prints a confirmation message.
