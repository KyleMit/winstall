Import-Module $PSScriptRoot\utils.psm1

$fonts = @(
    "FiraCode-NF",
    "FiraCode-NF-Mono"
)

function Test-InstallFonts {
    $scoopApps = scoop list 6>&1
    $missingApps = $fonts | Where-Object { !($scoopApps | Test-ContainsString $_ ) }
    $missingApps | ForEach-Object { Write-Output "Missing $_" }
    return $missingApps.Count -eq 0
}


function Invoke-InstallFonts {
    if (-not (Test-Command 'scoop')) {
        Write-Output "scoop cmdlet not found - run install scoop"
        Return $false
    }
    scoop bucket add nerd-fonts
    # requires elevation
    $fonts | ForEach-Object { scoop install $_ -g }
}

