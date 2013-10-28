export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="prose"
export EDITOR="vim"

plugins=(colorize brew)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

alias z="vim ~/.zshrc"
alias v="vim ~/.vim/vimrc"
alias vi="vim"
alias reload="exec $SHELL --login"
alias e="exit"
alias :q="exit"
alias r="rails"
alias va="vagrant"
alias be="bundle exec"
alias eh="sudo vim /etc/hosts"
alias l="ls -lha"

# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gs="git st"
alias gl="git l -30"
alias glm="gl --author=Brian"
alias gl1="git l1"
alias gup="git add padrao && git commit -m 'update padrao'"
alias gk="gitk &"
alias gc="git commit"
alias gcm="git commit -m"
alias gch="git checkout"
alias gp="git push"
alias gd="git diff"
alias gr="git reflog"
alias gdc="git diff --cached"
alias gt="git tag"
alias glt="git lt"
alias gtl="git lt"

# pg
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# mysql
alias mysql_start="mysql.server start"
alias mysql_stop="mysql.server stop"

# redis
alias redis_start="redis-server /usr/local/etc/redis.conf"

# use vim as man-page viewer
man() {
  PAGER="/bin/sh -c \"col -b | vim -R -c 'set ft=man' -\"" command man $@
}

showp() {
  lsof -i tcp:$1
}

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"