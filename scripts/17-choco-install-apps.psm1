Import-Module $PSScriptRoot\utils.psm1

$apps = (
    "deno",
    "git"
)

function Test-InstallChocoApps {

    # check if choco exists
    if (-not (Test-Command 'choco')) {
        Write-Output "choco not found"
        Return $false
    }

    # todo - check if listed apps are installed
    $installedApps = choco list
    $apps | ForEach-Object { [bool]($installedApps -like "*$_*") }
}


function Test-InstallChocoApps {

    # check if choco exists and download apps
    if (-not (Test-Command 'choco')) {
        Write-Output "choco not found"
        Return
    }

    # download apps
    $apps | ForEach-Object { choco install $_ -y }


}
