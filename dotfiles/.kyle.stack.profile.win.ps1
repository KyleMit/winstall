function cdso() {
    Set-Location -Path C:\code\StackOverflow
}

function dls() {
    Push-Location C:/code/DevLocalSetup
    git pull
    ./setup.bat
    Pop-Location
}

function so-migrate() {
    $cwd = Get-Location
    Set-Location C:/code/StackOverflow
    git pull

    Set-Location C:/code/StackOverflow/StackOverflow.Migrations
    ./migrate.local.bat # --force

    Set-Location C:/code/StackOverflow/Migrations
    ./migrate.local.channels.bat # --force

    Set-Location C:/code/StackOverflow/Sites.Migrations
    ./migrate.local.bat # --force

    Set-Location $cwd

}

function so-build {

    $buildTimer = [Diagnostics.Stopwatch]::StartNew()
    dotnet build C:\code\StackOverflow\StackOverflow.sln
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
        -AppLogo "C:\Users\kmitofsky\Pictures\windows\stack.png" `
        -Text "Build completed", "Build: $([Math]::Floor($buildTimer.Elapsed.TotalSeconds))s Ping: $([Math]::Floor($pingTimer.Elapsed.TotalSeconds))s Status: $status"
}

function so-socket {
    # make sure docker is running
    if ((docker ps 2>&1 | Out-String) -match "^error") {
        Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    }
    # start socket server
    dotnet run --project C:\code\StackOverflow\SocketServer2\SocketServer2.csproj
}

function so-test-migrate {
    # https://stackoverflowteams.com/c/stack-overflow/a/6046/675
    dotnet run --project C:\code\StackOverflow\utils\StackOverflow.Setup\StackOverflow.Setup.csproj -- network remove PublicTest
    dotnet run --project C:\code\StackOverflow\utils\StackOverflow.Setup\StackOverflow.Setup.csproj -- network new PublicTest
}

function so-test-integration {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$testName
    )
    dotnet test C:\code\StackOverflow\tests\StackOverflow.Tests.Integration\StackOverflow.Tests.Integration.csproj `
        --filter DisplayName~$testName `
        --logger "console;verbosity=normal"
}
function so-test-unit {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$testName
    )
    dotnet test C:\code\StackOverflow\tests\StackOverflow.Tests.Unit\StackOverflow.Tests.Unit.csproj `
        --filter DisplayName~$testName `
        --logger "console;verbosity=normal"
}

function so-datadog {
    # make sure data dog exists
    if (!(Test-Path -Path "C:\code\DogStatsMonitor")) {
        git clone git@github.com:StackEngLabs/DogStatsMonitor.git "C:\code\DogStatsMonitor"
    }
    # start socket server
    dotnet run --project C:\code\DogStatsMonitor\src\DogStatsMonitor\DogStatsMonitor.csproj
}

function so-ssms {
    C:\Windows\System32\runas.exe /user:STACKEXCHANGE\kmitofsky "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe"
}
