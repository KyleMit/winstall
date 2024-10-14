
$npmApps = @(
    "git-dirs",
    "@kylemit/cli-ls",
    "typescript"
)

function Test-ConfigureDefaultApps {
    $globalApps = npm list --global --depth=0 
    $globalAppsStr = $globalApps -Join ""
    $missingApps = $npmApps | Where-Object { !($globalAppsStr | Test-ContainsString $_ ) }
    $missingApps | ForEach-Object { Write-Output "Missing $_" }
    return $missingApps.Count -eq 0
}


function Invoke-ConfigureNpm {
    $npmApps | ForEach-Object { npm install $_ -g }   
}
