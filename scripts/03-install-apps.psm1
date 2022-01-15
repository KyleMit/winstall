Import-Module $PSScriptRoot\utils.psm1

function Invoke-InstallApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return
    }

    # download apps
    winget install Microsoft.VisualStudioCode
    winget install Postman.Postman
    winget install Mozilla.Firefox
    winget install SlackTechnologies.Slack
    winget install Armin2208.WindowsAutoNightMode
    winget install 7zip.7zip
    winget install VideoLAN.VLC
    winget install OBSProject.OBSStudio
    winget install Lexikos.AutoHotkey
    winget install Microsoft.PowerToys
    winget install Python.Python.3
    winget install WinDirStat.WinDirStat
    winget install Git.Git
    winget install GitHub.GitHubDesktop
    winget install Microsoft.VisualStudio.2022.Community
}
