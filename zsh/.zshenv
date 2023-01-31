# zshenv

# XDG {{{
#-----------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XAUTHORITY="${XDG_RUNTIME_DIR:-$HOME}/Xauthority"
# }}}

# general {{{
#-----------------------
export LANG=en_US.UTF-8
export LESSHISTFILE="$XDG_CACHE_HOME/.lesshist"
export DOTFILES="$HOME/.dotfiles"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# }}}

# docker {{{
#-----------------------
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# }}}

# editor {{{
#-----------------------
export EDITOR="nvim"
export VISUAL="$EDITOR"
# }}}

# golang {{{
#-----------------------
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
# export GOROOT="$XDG_DATA_HOME/go
# export GOPATH="$HOME/personal/development/go"
# export GOBIN="$GOPATH/bin"
# export GOCACHE="$XDG_CACHE_HOME/go-build"
# }}}

# gpg {{{
#-----------------------
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# }}}

# java {{{
#-----------------------
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# }}}

# node/nvm {{{
#-----------------------
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# }}}

# python {{{
#-----------------------
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export POETRY_HOME="$XDG_DATA_HOME/.poetry"
export POETRY_BIN="$POETRY_HOME/bin"
export POETRY_CACHE_DIR="$XDG_CACHE_HOME/pypoetry"
# }}}

# rust {{{
#-----------------------
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# }}}

# terraform {{{
#-----------------------
export TF_CLI_CONFIG_FILE="$XDG_CONFIG_HOME/terraform/terraformrc"
# }}}

# vim {{{
#-----------------------
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
# }}}

# zsh {{{
#-----------------------
skip_global_compinit=1
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZPROMPT="$ZDOTDIR/prompt"
export HISTFILE="$XDG_CACHE_HOME/zsh/zhistory"
export HISTSIZE=1000
export SAVEHIST=1000
# }}}

# PATH {{{
#-----------------------
typeset -U path

path=($HOME/.local/bin $path)
path=($POETRY_BIN $path)
path=($CARGO_HOME $path)
# }}}

# vim: fdm=marker ts=2 sw=2 et:
