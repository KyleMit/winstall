# load with source ~/.kyle.zshrc
# set options
SAVEHIST=16000
HISTSIZE=20000
HISTFILESIZE=20000
setopt inc_append_history  # Immediately append commands to the history file
# setopt share_history       # Share history across all zsh sessions
# unsetopt EXTENDED_HISTORY


# set prompt
eval "$(oh-my-posh init zsh --config ~/.kyle.omp.yaml)"

# set aliases
alias cls="clear"
alias python=python3
alias pip=pip3

# set functions
function dls() {
    pushd ~/Code/DevLocalSetup > /dev/null || return
    git pull && sudo ./setup.sh
    popd > /dev/null || return
}

function cdso() {
    cd ~/Code/StackOverflow
}


function restart-kestrel() {
  local plistLinkFile="$HOME/Library/LaunchAgents/com.stackexchange.KestrelProxy.plist"

  launchctl stop com.stackexchange.KestrelProxy
  launchctl unload $plistLinkFile
  launchctl load $plistLinkFile
  launchctl start com.stackexchange.KestrelProxy
}
