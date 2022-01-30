Import-Module $PSScriptRoot\utils.psm1

$apps = (
    "Google.Chrome",
    "Google.Chrome.Canary",
    "Microsoft.VisualStudioCode",
    "Postman.Postman",
    "Mozilla.Firefox",
    "SlackTechnologies.Slack",
    "Armin2208.WindowsAutoNightMode",
    "7zip.7zip",
    "VideoLAN.VLC",
    "OBSProject.OBSStudio",
    "Lexikos.AutoHotkey",
    "Microsoft.PowerToys",
    "Python.Python.3",
    "WinDirStat.WinDirStat",
    "Git.Git",
    "GitHub.GitHubDesktop",
    "GitHub.cli",
    "Microsoft.VisualStudio.2022.Community",
    "Chocolatey.ChocolateyGUI"
)

function Test-InstallApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return $false
    }

    # download apps


    $apps | ForEach-Object { winget list --id $_ }
}


function Invoke-InstallApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return
    }

    # download apps
    # https://docs.microsoft.com/en-us/windows/package-manager/winget/install
    $apps | ForEach-Object { winget install --id $_ --exact}


}

function Invoke-InstallNewApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return
    }

    # download apps
    # https://docs.microsoft.com/en-us/windows/package-manager/winget/install
    $apps | ForEach-Object { winget install --id $_ --exact}


}


$winApps = winget list
