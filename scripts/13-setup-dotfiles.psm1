Import-Module $PSScriptRoot\utils.psm1

$files = @(
    @{ file = ".kyle.bashrc"; dest = "$env:USERPROFILE\.kyle.bashrc" }
    @{ file = ".kyle.dict.txt"; dest = "$env:UserProfile\.kyle.dict.txt" }
    @{ file = ".kyle.gitconfig"; dest = "$env:USERPROFILE\.kyle.gitconfig" }
    @{ file = ".kyle.profile.ps1"; dest = "$env:USERPROFILE\.kyle.profile.ps1" }
    @{ file = ".kyle.omp.yaml"; dest = "$env:USERPROFILE\.kyle.omp.yaml" }
    @{ file = "AutoHotkey.ahk"; dest = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.ahk" }
)

$imports = @(
    @{ 
        profile = "$env:USERPROFILE\.bashrc"; 
        import = "test -f ~/.kyle.bashrc && . ~/.kyle.bashrc" 
    },
    @{ 
        profile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"; 
        import = ". $env:USERPROFILE/.kyle.profile.ps1" 
    },
    @{ 
        profile = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"; 
        import = ". $env:USERPROFILE/.kyle.profile.ps1" 
    }
)


function Test-SetupDotfiles {
    $installedOhMyPosh = Test-Command 'oh-my-posh'
    $notLinkedFiles = $files | Where-Object { (Get-Item $_.dest -ErrorAction SilentlyContinue).LinkType -ne "HardLink" }

    # test git config
    $gitImported = (git config --global include.path) -eq "./.kyle.gitconfig"

    # test file imports
    $notImported = $imports | Where-Object { !(Select-String -Path $_.profile -Pattern $_.import) }

    $isSetup = $installedOhMyPosh -and
           $notLinkedFiles.Count -eq 0 -and
           $gitImported -and
           $notImported.Count -eq 0

    return $isSetup
}

function Invoke-SetupDotfiles {
    winget install JanDeDobbeleer.OhMyPosh

    # create hard link to local files
    $files | ForEach-Object {
        $file = $_.file
        $dest = $_.dest
        New-Item -ItemType HardLink -Path $dest -Target ".\dotfiles\$file"
    }

    # link git config
    git config --global include.path "./.kyle.gitconfig"
    
    # add import statements
    $imports | ForEach-Object {
        $profile = $_.profile
        $import = $_.import
        if (!(Select-String -Path "$profile" -Pattern $import -SimpleMatch)) {
            Add-Content -Path $profile -Value "`n$import" 
        }
    }

}
