This script offboards an AD user by disabling the account and cleaning up group membership.

It:
- imports the ActiveDirectory module,
- asks for a SamAccountName,
- looks up the user and exits if not found,
- disables the account,
- removes the user from all groups except `Domain Users`,
- moves the user object to `OU=Disabled-Users,OU=Company,DC=lab,DC=local`, and
- prints a completion message.
