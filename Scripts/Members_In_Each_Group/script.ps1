#printing members of each group in the OU
$OU = "OU=Groups,DC=example,DC=com"

Get-ADGroup -Filter * -SearchBase $OU | ForEach-Object {
    $GroupName = $_.Name
    Write-Host "Members of group: $GroupName"
    Get-ADGroupMember -Identity $GroupName | ForEach-Object {
        Write-Host $_.SamAccountName
    }
    Write-Host "-----------------------------"
}
