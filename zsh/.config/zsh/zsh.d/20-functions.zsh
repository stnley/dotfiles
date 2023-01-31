dots() {
  cd $DOTFILES
}

# autols do an ls after each cd
autols() (
ls
)

g() {
if [ "$#" -eq 0 ]; then
  git status --short --branch
else
  git "$@"
fi
}
compdef g=git

pyclean() (
find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
)

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }


# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


# ff - find a file and open it in your editor
ff() (
if [ -n "${EDITOR+1}" ]; then
  editor="$EDITOR"
else
  echo "No \$EDITOR set for session"
  return 1
fi
local file
file=$(find ${1:-.} -type f 2> /dev/null | fzf +m) && "$editor" "$file"
)

# TODO: make this work in CDE
load-nvmrc() {
local nvmrc_path="$(nvm_find_nvmrc)"

if [ -n "$nvmrc_path" ]; then
  local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
  elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
    nvm use
  fi
elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
  echo "Reverting to nvm default version"
  nvm use default
fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd autols
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# vim: ts=2 sw=2 et:
