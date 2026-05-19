export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# zsh-autosuggestions and zsh-syntax-highlighting must be installed per machine:
#   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z fzf fzf-tab zsh-completions)

source $ZSH/oh-my-zsh.sh

# fzf-tab: show folder contents preview when tabbing through directories
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --color=always --icons $realpath'

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

source ~/.dotfiles/aliases
source ~/.dotfiles/functions

if [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.dotfiles/aliases.mac
else
  source ~/.dotfiles/aliases.linux
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
