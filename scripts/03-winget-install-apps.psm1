Import-Module $PSScriptRoot\utils.psm1

# todo - split into utlities vs apps
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
    "RProject.R",
    "SlackTechnologies.Slack",
    "VideoLAN.VLC",
    "WinDirStat.WinDirStat",
    "Samsung.DeX",
    "Facebook.Messenger",
    "JanDeDobbeleer.OhMyPosh",
    "Adobe.Acrobat.Reader.64-bit",
    "AgileBits.1Password",
    "Insomnia.Insomnia",
    "jqlang.jq",
    "WiresharkFoundation.Wireshark",
    "Google.AndroidStudio",
    "Insecure.Npcap"
)

function Test-InstallApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return $false
    }

    # todo - check if listed apps are installed
    # $apps | ForEach-Object { winget list --id $_ }
}


function Invoke-InstallApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return
    }

    # download apps
    # https://docs.microsoft.com/en-us/windows/package-manager/winget/install
    $apps | ForEach-Object { winget install --id $_ --exact }


}

function Invoke-InstallNewApps {

    # winget check if it exists and download
    if (-not (Test-Command 'winget')) {
        Write-Output "winget cmdlet not found"
        Return
    }

    # download apps
    # https://docs.microsoft.com/en-us/windows/package-manager/winget/install
    $apps | ForEach-Object { winget install --id $_ --exact }


}

# command to look for and install app updates

