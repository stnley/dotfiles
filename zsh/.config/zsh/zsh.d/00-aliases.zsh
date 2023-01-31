alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# alias g='git'
# compdef g='git'

if [ -x $(command -v "lsd") ]; then
    alias ls="lsd --config-file $XDG_CONFIG_HOME/lsd/config.yml"
    alias ll='ls --blocks=permission,size,date,name'
    alias tree='ls --tree'
else
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -gho'
fi
alias lall='ll -A'

alias grep='grep --color=auto'

alias sudo='nocorrect sudo'

alias vi='vim'
if [[ -n "$(command -v nvim)" ]]; then
  alias vim='nvim'
fi

alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

alias psh="poetry shell"

if [[ -n "$(command -v bat)" ]]; then
  alias cat="bat --paging=never"
fi

# vim: ts=2 sw=2 et:
