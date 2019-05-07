export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export GOPATH="$HOME/dev/go"
export PATH=$PATH:$GOPATH/bin
export CDPATH=$GOPATH/src/github.com/:$HOME/dev
export HISTTIMEFORMAT="%m/%d/%y %T "
export HISTFILESIZE=
export HISTSIZE=
export NVM_DIR=~/.nvm
export PATH=$PATH:$(go env GOPATH)/bin
export TERM=xterm-256color
export ETCDCTL_API=3
export PROMPT_COMMAND='history -a'
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

build_sensu_smartos() {
  cd sensu/sensu-go
  GOOS=solaris GOARCH=amd64 ./build.sh build_backend
  GOOS=solaris GOARCH=amd64 ./build.sh build_agent
}

alias k=kubectl

alias gtc="test -coverprofile=./coverprofile.out && go tool cover -html=./coverprofile.out"
eval "$(hub alias -s)"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="$cyn\u$grn@$yel\h.$red\W$pur\$(parse_git_branch)🐓 $end"

# enable bash completion to work
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mercedes/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/mercedes/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mercedes/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/mercedes/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# hook direnv into bash
eval "$(direnv hook bash)"

