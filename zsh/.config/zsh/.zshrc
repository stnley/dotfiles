# zshrc

# options {{{
#-----------------------
setopt autocd
setopt extendedglob
unsetopt beep
# }}}

# more colors {{{
#-----------------------
if [[ -r "$XDG_CONFIG_HOME/dircolors" ]]; then
  eval $(dircolors "$XDG_CONFIG_HOME/dircolors")
fi
# }}}

# prompt {{{
#-----------------------
fpath=($ZPROMPT $fpath)
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
prompt pure
# }}}

#  key bindings {{{
#-----------------------
bindkey -v
bindkey '^[[Z' autosuggest-accept

zmodload zsh/complist # NOTE: must be loaded before compinit
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# }}}

# completion {{{
#-----------------------
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true

zstyle ':completion:*:*:*:*:options' list-colors '=^(-- *)=36'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d--%f'
zstyle ':completion:*:*:*:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}


# TODO: this is the path for zsh-users completions on arch, make it generic for debian based distro
if [[ -d "/usr/share/zsh/site-functions/" ]]; then
  fpath=("/usr/share/zsh/site-functions/" $fpath)
fi

autoload -Uz compinit bashcompinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
bashcompinit
# }}}

# fzf {{{
#-----------------------
# TODO: these paths are for arch only, make it generic for debian based distro
export FZF_DEFAULT_OPTS="\
  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

if [[ -r "/usr/share/fzf/completion.zsh" ]]; then
  source "/usr/share/fzf/completion.zsh"
fi

if [[ -r "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi
# }}}

# auto-suggestions {{{
#-----------------------
if [[ -r "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
# }}}

# syntax-highlighting {{{
#-----------------------
# syntax-highlighting module
if [[ -r "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# color scheme
if [[ -r "$ZDOTDIR/syntax-theme/zsh-syntax-highlighting.sh" ]]; then
  source "$ZDOTDIR/syntax-theme/zsh-syntax-highlighting.sh"
fi
# }}}

# nvm {{{
#-----------------------
# TODO: this sources the nvm wrapper script from AUR, make it generic for debian based distro
if [[ -r "/usr/share/nvm/init-nvm.sh" ]]; then
  source "/usr/share/nvm/init-nvm.sh"
fi
# }}}

# additional scripts {{{
#-----------------------
for file ($ZDOTDIR/zsh.d/*.zsh) source $file
# }}}

# vim: fdm=marker ts=2 sw=2 et:
