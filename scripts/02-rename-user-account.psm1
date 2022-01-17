$oldName = "Kylem"
$newName = "kylemit"

function Test-RenameUser {
    Return [bool](Get-LocalUser $newName)
}


function Invoke-RenameUser {
    if ($env:UserName -ne "admin") {
        Write-Output "Current User: $env:UserName"
        Write-Output "Please log out and log back in as admin"
        Return
    }

    Write-Output "Renaming kylem..."

    # profile names
    $oldProfilePath = "C:\Users\$oldName"
    $newProfilePath = "C:\Users\$newName"

    # rename folder
    Rename-Item -Path $oldProfilePath -NewName $newProfilePath

    # get profile key
    $profileKeys = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*"
    $userProfileItem = Get-ItemProperty -Path $profileKeys | Where-Object ProfileImagePath -eq $oldProfilePath

    # update profile image path
    Set-ItemProperty -Path $userProfileItem.PSPath -Name ProfileImagePath -Value $newProfilePath

    # set local username
    Rename-LocalUser -Name $oldName -NewName $newName

}

