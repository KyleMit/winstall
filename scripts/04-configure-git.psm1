
function Test-ConfigureGit {
    # username & email
    return [bool](git config --global user.name) -and
           [bool](git config --global user.email) -and
           [bool](git config --global init.defaultBranch)
}


function Invoke-ConfigureGit {
    # username & email
    git config --global user.name "kylemit"
    git config --global user.email "Kylemit@gmail.com"
    git config --global init.defaultBranch main
}
