
function Test-ConfigureGit {
    # TODO check if we have all repos
    Test-Path C:/code/*
}


function Invoke-ConfigureGit {
    $repoDir = "C:\Code\"
    New-Item -ItemType Directory -Force -Path $repoDir
    Set-Location $repoDir
}


gh repo list myorgname --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done

gh repo list KyleMit --limit 10 | awk '{print $1; }' | xargs -L1 gh repo clone

gh repo list KyleMit --limit 10 --json nameWithOwner,defaultBranchRef --jq ".[]|.nameWithOwner" | xargs -L1 gh repo clone

gh repo list KyleMit --limit 10 --json nameWithOwner,defaultBranchRef `
  --jq ".[] | { nameWithOwner , defaultBranch: .defaultBranchRef.name}"
