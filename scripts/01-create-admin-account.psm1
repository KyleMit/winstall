
function Invoke-CreateLocalAdmin {
    if (Get-LocalUser admin) {
        # admin already exists, we're all set
        Return
    }

    Write-Output "Creating admin acct..."

    # create new admin account
    $password = Read-Host -AsSecureString
    New-LocalUser "admin" -Password $password -FullName "Local Admin" -Description "Admin local account"
    Add-LocalGroupMember -Group "Administrators" -Member "admin"
}
