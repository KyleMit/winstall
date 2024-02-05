
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$registryKey = "DisallowShaking"
$registryValue = 1

function Test-AeroShake {
    # Get the current value of the registry key
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryKey -ErrorAction SilentlyContinue

    $alreadySet = $currentValue -and $currentValue.$registryKey -eq $registryValue

    return $alreadySet
}


function Invoke-AeroShake {
    # Check if the registry path exists
    if (!(Test-Path $registryPath)) {
        Write-Host "Creating registry path: $registryPath"
        New-Item -Path $registryPath -Force | Out-Null
    }

    # Set the registry value to disable Aero Shake
    Set-ItemProperty -Path $registryPath -Name $registryKey -Value $registryValue

    Write-Host "Aero Shake has been disabled."
}

