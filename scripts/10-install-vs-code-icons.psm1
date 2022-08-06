$customIconFolder = "$env:AppData\Code\User\vsicons-custom-icons"

function Test-SetupVsCodeCustomIcons {
    # check if we have any repos
    Test-Path $customIconFolder\*
}


function Invoke-SetupVsCodeCustomIcons {
    New-Item -ItemType Directory -Force -Path $customIconFolder
    Copy-Item "./assets/file_type_eleventy.svg" -Destination $customIconFolder
    Copy-Item "./assets/file_type_light_eleventy.svg" -Destination $customIconFolder
}
