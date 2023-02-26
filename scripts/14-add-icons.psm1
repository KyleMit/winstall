
function Test-IconsInstalled {
    Test-Path "$env:USERPROFILE\.icons\*"
}


function Invoke-InstallIcons {
    Copy-Item -Path .\assets\.icons\ -Destination $env:USERPROFILE -Recurse
}






