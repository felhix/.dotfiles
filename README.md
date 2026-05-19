# dotfiles

## What's here
- `zshrc` — oh-my-zsh config (robbyrussell)
- `aliases` — shared aliases (git, docker, python)
- `aliases.mac` / `aliases.linux` — OS-specific
- `functions` — shell utilities (`fs`, `mkcdir`)
- `claude.md` — shared Claude Code global config

## Install on a new machine
1. Install [oh-my-zsh](https://ohmyz.sh) first
2. `git clone git@github.com:felhix/dotfiles.git ~/.dotfiles`
3. `cd ~/.dotfiles && ./install.sh`

## Machine-specific config
Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
