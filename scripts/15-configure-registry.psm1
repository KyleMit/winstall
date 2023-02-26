# https://superuser.com/q/958690/180163

$thumbnailPath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband"
$thumbnailKey = "MinThumbSizePx"
$thumbnailValue = 500

function Test-SetupRegistryCustomizations {
    $currentVal = (Get-ItemProperty -Path $thumbnailPath -Name $thumbnailKey -ErrorAction Ignore).$thumbnailKey
    $correctVal = $currentVal -eq $thumbnailValue
    return $correctVal
}


function Invoke-SetupRegistryCustomizations {
    If ( !(Test-Path $thumbnailPath) ) { New-Item -Path $thumbnailPath -Force; };
    New-ItemProperty `
        -Path $thumbnailPath `
        -Name $thumbnailKey `
        -Value $thumbnailValue `
        -PropertyType "$([Microsoft.Win32.RegistryValueKind]::DWord)" `
        -Force;
}
