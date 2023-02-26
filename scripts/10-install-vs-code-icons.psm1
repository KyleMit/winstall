$customIconFolder = "$env:AppData\Code\User\vsicons-custom-icons"

$icons = @(
    "file_type_eleventy.svg",
    "file_type_light_eleventy.svg"
)

function Test-SetupVsCodeCustomIcons {
    $missingIcons = $icons | Where-Object {
        -not (Test-Path (Join-Path $customIconFolder $_))
    }
    $missingIcons | ForEach-Object { Write-Output "Missing $_" }
    return $missingIcons.Count -eq 0
}


function Invoke-SetupVsCodeCustomIcons {
    New-Item -ItemType Directory -Force -Path $customIconFolder
    $icons | ForEach-Object {
        Copy-Item "./assets/$_" -Destination $customIconFolder
    }

    Write-Output "Open VS Code and Run 'Apply Icon Customizations'"
}
