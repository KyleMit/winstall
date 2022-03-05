Import-Module $PSScriptRoot\utils.psm1

$apps = (
    "7zip.7zip",
    "Armin2208.WindowsAutoNightMode",
    "Microsoft.AzureStorageExplorer",
    "Chocolatey.ChocolateyGUI",
    "Elgato.ControlCenter",
    "Git.Git",
    "GitHub.cli",
    "GitHub.GitHubDesktop",
    "Google.Chrome.Canary",
    "Google.Chrome",
    "Lexikos.AutoHotkey",
    "Microsoft.PowerToys",
    "Microsoft.VisualStudio.2022.Community",
    "Microsoft.VisualStudioCode",
    "Microsoft.dotnet",
    "Mozilla.Firefox",
    "OBSProject.OBSStudio",
    "OpenJS.NodeJS",
    "Postman.Postman",
    "Python.Python.3",
    "SlackTechnologies.Slack",
    "VideoLAN.VLC",
    "WinDirStat.WinDirStat",
    "Samsung.DeX"
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
