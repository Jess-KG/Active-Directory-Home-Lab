#Bulk add or remove users from a group from a CSV file

Import-Module ActiveDirectory

# Specify the path to the CSV file containing user information
$csvPath = "C:\Path\To\Your\CSVFile.csv"

Write-Host "Do you want to add or remove users from the group?"
$choice = Read-Host "(Enter 1 for 'add' or 2 for 'remove')"

if ($choice -eq "1") {
    $action = "add"
} elseif ($choice -eq "2") {
    $action = "remove"
} else {
    Write-Host "Invalid choice. Please enter 1 or 2."
    exit
}

$groupName = Read-Host "Enter the name of the group"

#validate if the group exists
$group = Get-ADGroup -Identity $groupName -ErrorAction SilentlyContinue
if (-not $group) {
    Write-Host "Group '$groupName' does not exist."
    exit
}

# Import the CSV file
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    $samAccountName = $user.SamAccountName

    # Validate if the user exists
    $adUser = Get-ADUser -Identity $samAccountName -ErrorAction SilentlyContinue
    if (-not $adUser) {
        Write-Host "User '$samAccountName' does not exist. Skipping."
        continue
    }

    if ($action -eq "add") {
        Add-ADGroupMember -Identity $groupName -Members $samAccountName
        Write-Host "Added user '$samAccountName' to group '$groupName'."
    } elseif ($action -eq "remove") {
        Remove-ADGroupMember -Identity $groupName -Members $samAccountName -Confirm:$false
        Write-Host "Removed user '$samAccountName' from group '$groupName'."
    }
}

