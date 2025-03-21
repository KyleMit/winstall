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

# set functions
dls() {
    pushd ~/Code/DevLocalSetup > /dev/null || return
    git pull && sudo ./setup.sh
    popd > /dev/null || return
}

cdso() {
    cd ~/Code/StackOverflow
}

function npm() {
  if [[ "$(pwd)" == "$HOME/Code/StackOverflow" ]]; then
    echo "You need to navigate into the 'StackOverflow' subdirectory before running 'npm i'."
    return 1
  fi
  command npm "$@"
}
