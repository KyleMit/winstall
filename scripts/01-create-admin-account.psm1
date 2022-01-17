
function Test-CreateLocalAdmin {
    Return [bool](Get-LocalUser admin)
}



function Invoke-CreateLocalAdmin {
    # admin already exists, we're all set
    if (Test-CreateLocalAdmin) { Return }

    Write-Output "Creating admin acct..."

    # create new admin account
    $password = Read-Host -AsSecureString
    New-LocalUser "admin" -Password $password -FullName "Local Admin" -Description "Admin local account"
    Add-LocalGroupMember -Group "Administrators" -Member "admin"
}
