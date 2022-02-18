$repoDir = "C:\code"
$userName = "KyleMit"

function Test-ConfigureGitRepos {
    # check if we have any repos
    Test-Path $repoDir\*
}


function Invoke-ConfigureGitRepos {

    New-Item -ItemType Directory -Force -Path $repoDir
    $repos = gh repo list $userName --limit 999 --json name --jq ".[]|.name"
    $repos | ForEach-Object {
      gh repo clone $_ $repoDir\$_
    }
}


