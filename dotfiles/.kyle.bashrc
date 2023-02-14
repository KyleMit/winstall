# set aliases
alias cls="tput reset"
alias zip="tar.exe"
alias ridk="ridk.cmd"
alias sam="sam.cmd"

alias pbcopy="clip"
alias redis-cli="rdcli"
alias lua="lua54"
alias open="start"

alias ls='ls --color=auto'

alias dls='
pushd /c/code/DevLocalSetup && \
git pull && \
./setup.sh && \
popd
'

alias migrate='
pushd /c/code/StackOverflow/StackOverflow.Migrations && \
./migrate.local.sh --force && \
popd && \
pushd /c/code/StackOverflow/Migrations && \
./migrate.local.channels.sh --force && \
popd && \
pushd /c/code/StackOverflow/Sites.Migrations && \
./migrate.local.sh --force && \
popd
'

PROMPT_COMMAND='history -a'
HISTSIZE=20000
HISTFILESIZE=20000

function winget { cmd.exe /c "winget $1 $2 $3";}
function mklink { cmd.exe /c "mklink $1 $2 $3";}
# function python { cmd.exe /c "python $1 $2 $3";}

eval "$(oh-my-posh init bash --config ~/.kyle.omp.yaml)"
