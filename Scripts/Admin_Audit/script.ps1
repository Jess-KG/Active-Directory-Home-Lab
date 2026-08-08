#Find all users part of admin groups

$adminGroups = @("Domain Admins", "Enterprise Admins", "Administrators", "Schema Admins")

$report = foreach($groupName in $adminGroups) {
    $group = Get-ADGroup -Identity $groupName -ErrorAction SilentlyContinue
    if (-not $group) {
        Write-Warning "Group '$groupName' not found."
        continue
    }

    $members = Get-ADGroupMember -Identity $group -Recursive -ErrorAction SilentlyContinue

    foreach ($member in $members) {
        if ($member.objectClass -eq 'user') {
            $user = Get-ADUser -Identity $member -Properties DisplayName, EmailAddress, Enabled -ErrorAction SilentlyContinue
            if ($user) {
                [PSCustomObject]@{
                    GroupName    = $groupName
                    UserName     = $user.SamAccountName
                    DisplayName  = $user.DisplayName
                    EmailAddress = $user.EmailAddress
                    Enabled      = $user.Enabled
                }
            }
        }
    }
}

$report | Format-Table -AutoSize
$report | Export-Csv -Path "AdminGroupMembersReport.csv" -NoTypeInformation