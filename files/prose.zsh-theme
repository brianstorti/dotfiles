function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

git_prompt_info () {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


if [ `uname` = "Linux" ]; then
PROMPT='
(linux) %{$fg_bold[yellow]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)$ '
else
PROMPT='
%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)$ '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[black]%} ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

RPROMPT='%{$reset_color%}'
