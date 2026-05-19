# dotfiles

## What's here
- `zshrc` — oh-my-zsh config (robbyrussell)
- `aliases` — shared aliases (git, docker, python)
- `aliases.mac` / `aliases.linux` — OS-specific
- `functions` — shell utilities (`fs`, `mkcdir`)
- `claude.md` — shared Claude Code global config

## Install on a new machine
1. Install [oh-my-zsh](https://ohmyz.sh)
2. Install zsh plugins:
   ```sh
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```
3. `git clone git@github.com:felhix/.dotfiles.git ~/.dotfiles`
4. `cd ~/.dotfiles && ./install.sh`

## Machine-specific config
Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
