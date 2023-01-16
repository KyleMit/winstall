Import-Module $PSScriptRoot\utils.psm1

function Test-InstallScoop {
    return Test-Command 'scoop'
}


function Invoke-InstallScoop {
    Invoke-WebRequest get.scoop.sh | Invoke-Expression
}
