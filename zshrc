export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

source ~/.dotfiles/aliases
source ~/.dotfiles/functions

if [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.dotfiles/aliases.mac
else
  source ~/.dotfiles/aliases.linux
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
