
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias vi='vim'
alias n='netstat -tpe'

PS1='\[\e[0;32m\]\u@\h:\[\e[0;33m\]\w\[\e[0m\]> '
export PATH=$PATH:~/bin

export EDITOR=/usr/bin/vim
export xterm=xterm-256color
export BROWSER=google-chrome-stable


