# dotfiles

## What's here

```
zsh/          zshrc, aliases (shared + OS-specific), functions
git/          gitconfig (delta as diff viewer)
claude/       CLAUDE.md — shared Claude Code global config
bin/          dotfiles-health — verify your setup
Brewfile      macOS dependencies (brew bundle)
install.sh    bootstrap a new machine end to end
```

## Install on a new machine

```sh
git clone git@github.com:felhix/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

The script handles: Homebrew + all packages, oh-my-zsh, zsh plugins, symlinks, and git identity migration.

Preview without making changes:
```sh
./install.sh --dry-run
```

Verify everything is set up correctly:
```sh
bin/dotfiles-health
```

## Manual steps (not automated)

**Git identity on a fresh machine** — if no prior gitconfig existed, set your identity:
```sh
git config --file ~/.gitconfig.local user.name "Your Name"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

**Linux Nerd Font** — required for icons in `eza`:
- Download from [nerdfonts.com](https://www.nerdfonts.com) (0xProto Nerd Font recommended)
- Extract to `~/.local/share/fonts/`
- Run `fc-cache -fv`
- Set the font in your terminal preferences

## Machine-specific config

Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
