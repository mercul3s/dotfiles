export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
#export CDPATH=$GOPATH/src/github.com/:$HOME/dev
export HISTTIMEFORMAT="%m/%d/%y %T "
export HISTFILESIZE=
export HISTSIZE=
export NVM_DIR=~/.nvm
export PATH=$PATH:$(go env GOPATH)/bin
export TERM=xterm-256color
export ETCDCTL_API=3
export AWS_DEFAULT_REGION="us-east-1"
export PROMPT_COMMAND='history -a'
export PATH="${PATH}:${HOME}/.krew/bin"
export PIPENV_VERBOSITY=-1
alias vim='/usr/local/bin/vim'

# Bash Prompt Color Variables
blu="\[\033[34m\]"
cyn="\[\033[36m\]"
grn="\[\033[32m\]"
yel="\[\033[33m\]"
red="\[\033[31m\]"
pur="\[\033[35m\]"
gry="\[\033[37m\]"
end="\[\033[00m\]"

alias k=kubectl
alias kd='kubectl describe'
alias tf=terraform

alias gtc="test -coverprofile=./coverprofile.out && go tool cover -html=./coverprofile.out"
eval "$(hub alias -s)"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="$cyn\u$grn@$yel\h.$red\W$pur\$(parse_git_branch)$end$ "

# enable bash completion to work
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# enable git autocompletion
source $HOME/.git-completion.bash

# hook direnv into bash
eval "$(direnv hook bash)"


complete -C /usr/local/Cellar/tfenv/1.0.1/versions/0.12.3/terraform terraform

source ~/.bashrc
