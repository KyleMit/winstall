function cdso() {
    Set-Location -Path ~/Code/StackOverflow
}

function dls() {
    Push-Location ~/Code/DevLocalSetup
    git pull
    sudo ./setup.sh
    Pop-Location
}

function so-migrate() {
    $cwd = Get-Location
    Set-Location ~/Code/StackOverflow
    git pull

    Set-Location ~/Code/StackOverflow/StackOverflow.Migrations
    ./migrate.local.bat # --force

    Set-Location ~/Code/StackOverflow/Migrations
    ./migrate.local.channels.bat # --force

    Set-Location ~/Code/StackOverflow/Sites.Migrations
    ./migrate.local.bat # --force

    Set-Location $cwd

}

function so-build {

    $buildTimer = [Diagnostics.Stopwatch]::StartNew()
    dotnet build ~/Code/StackOverflow/StackOverflow.sln
    $buildTimer.Stop()
    # Start-IISAppPools # requires admin

    # ping site
    $pingTimer = [Diagnostics.Stopwatch]::StartNew()

    try {
        $status = Invoke-WebRequest "https://meta.stackexchange.local/" | Select-Object -ExpandProperty StatusCode
    }
    catch {
        Write-Warning "Error launching Meta" -WarningAction Continue
        $status = 500
    }

    $pingTimer.Stop()

    # ping user
    # Install-Module -Name BurntToast
    New-BurntToastNotification `
        -AppLogo "~/Pictures/windows/stack.png" `
        -Text "Build completed", "Build: $([Math]::Floor($buildTimer.Elapsed.TotalSeconds))s Ping: $([Math]::Floor($pingTimer.Elapsed.TotalSeconds))s Status: $status"
}

function so-socket {
    # make sure docker is running
    if ((docker ps 2>&1 | Out-String) -match "^error") {
        Start-Process "C:/Program Files/Docker/Docker/Docker Desktop.exe"
    }
    # start socket server
    dotnet run --project ~/Code/StackOverflow/SocketServer2/SocketServer2.csproj
}

function so-test-migrate {
    # https://stackoverflowteams.com/c/stack-overflow/a/6046/675
    dotnet run --project ~/Code/StackOverflow/utils/StackOverflow.Setup/StackOverflow.Setup.csproj -- network remove PublicTest
    dotnet run --project ~/Code/StackOverflow/utils/StackOverflow.Setup/StackOverflow.Setup.csproj -- network new PublicTest
}

function so-test-integration {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$testName
    )
    dotnet test ~/Code/StackOverflow/tests/StackOverflow.Tests.Integration/StackOverflow.Tests.Integration.csproj `
        --filter DisplayName~$testName `
        --logger "console;verbosity=normal"
}
function so-test-unit {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$testName
    )
    dotnet test ~/Code/StackOverflow/tests/StackOverflow.Tests.Unit/StackOverflow.Tests.Unit.csproj `
        --filter DisplayName~$testName `
        --logger "console;verbosity=normal"
}

function so-datadog {
    # make sure data dog exists
    if (!(Test-Path -Path "~/Code/DogStatsMonitor")) {
        git clone git@github.com:StackEngLabs/DogStatsMonitor.git "~/Code/DogStatsMonitor"
    }
    # start socket server
    dotnet run --project ~/Code/DogStatsMonitor/src/DogStatsMonitor/DogStatsMonitor.csproj
}

