#source ~/dev/scripts/git-completion.bash

export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="~/dev/scripts:$PATH"
export PATH="~/dev/passphrase:$PATH"
export PATH="/usr/local/sbin:$PATH"
export GOPATH="/home/mercedes/dev/go"
export PATH=$PATH:$GOPATH/bin
export CDPATH=${CDPATH}:${GOPATH}/src/github.com:${GOPATH}/src/golang.org:~/dev
export HISTTIMEFORMAT="%m/%d/%y %T "
export HISTFILESIZE=
export HISTSIZE=
export NVM_DIR=~/.nvm
export PATH=$PATH:$(go env GOPATH)/bin
export TERM=xterm-256color
export ETCDCTL_API=3

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

#alias build_smartos="$(build_sensu_smartos)"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="$cyn\u$grn@$yel\h.$red\W$pur\$(parse_git_branch)$gry$ $end"

if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mercedes/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/mercedes/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mercedes/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/mercedes/Downloads/google-cloud-sdk/completion.bash.inc'; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# hook direnv into bash
eval "$(direnv hook bash)"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
