$pathToExclude = "C:\code"

function Test-WindowsDefenderExclusionList {
    $paths = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
    return $paths -contains $pathToExclude
}


function Invoke-WindowsDefenderExclusionList {
    Add-MpPreference -ExclusionPath $pathToExclude
}
