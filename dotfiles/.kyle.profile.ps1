# cli config
oh-my-posh init pwsh --config $env:USERPROFILE\.kyle.omp.yaml | Invoke-Expression

# linux compat
New-Alias which get-command


function touch {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        (Get-Item -Path $Path).LastWriteTime = Get-Date
    }
    else {
        New-Item -Type File -Path $Path
    }
}

function Start-IISAppPools {
    # TODO elevate permissions
    if (!(Get-Module | Where-Object { $_.Name -eq 'IISAdministration' })) {
        Import-Module IISAdministration
    }

    # TODO - need to elevate to do this...?
    Get-IISAppPool | Where-Object { $_.State -eq 'Stopped' } | ForEach-Object { $_.Start() }
}
