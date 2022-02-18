

function Test-ConfigureGitHub {
    $resp = cmd /c gh auth status '2>&1'
    $notLoggedIn = $resp -Match "You are not logged into"
    return -not $notLoggedIn
}


function Invoke-ConfigureGithub {
    gh auth login
    # gh config set -h github.com git_protocol ssh
}
