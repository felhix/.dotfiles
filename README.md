# dotfiles

![Terminal screenshot](example.png)

![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) ![Shell](https://img.shields.io/badge/shell-zsh-green) ![Prompt](https://img.shields.io/badge/prompt-starship-DD0B78)

An opinionated terminal setup: beautiful output, zero friction across machines, and pre-made choices so you stop configuring and start working.

## 1. 🧠 Philosophy

> The terminal is not just a black screen. It should be fast, readable, and — honestly — nice to look at. This repo is the full setup I've settled on after iteration: a prompt that shows what I need at a glance, tools that replace noisy defaults with something better, and a single command to reproduce it anywhere.

The decisions are opinionated on purpose. A blank slate takes days to tune. This takes one `./install.sh`.

## 2. 📦 What's here

| Path | Tool | Why |
|------|------|-----|
| `starship/` | [Starship](https://starship.rs) | Cross-shell prompt written in Rust — shows git branch, status, and context instantly, without slowing the shell down |
| `zsh/` | oh-my-zsh + custom aliases | Short aliases for git, Docker, Python, and navigation; shared across OS with mac/linux splits for anything platform-specific |
| `git/` | [delta](https://dandavison.github.io/delta/) | Replaces the default `git diff` pager with side-by-side diffs, line numbers, and syntax highlighting |
| `claude/` | CLAUDE.md | Shared Claude Code config — how I want AI assistance to behave globally |
| `bin/` | `dotfiles-health` | Verify the whole setup is wired up correctly after install |
| `Brewfile` | Homebrew bundle | All macOS dependencies in one place — `brew bundle` installs everything |
| `install.sh` | Bootstrap | Handles Homebrew, oh-my-zsh, zsh plugins, symlinks, and git identity in one run |

Key aliases: `ls` → `eza --icons`, `cat` → `bat`, `ll` → `eza -lah --icons --git`, `gls` → decorated git log graph.

## 3. 🚀 Install it

### 3.1. 🔧 Manual steps (not automated)

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

### 3.2. ⚡ Automated

```sh
git clone git@github.com:felhix/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

Preview without making changes:
```sh
./install.sh --dry-run
```

Verify everything is set up correctly:
```sh
bin/dotfiles-health
```

### 3.3. 💻 Machine-specific config

> [!TIP]
> Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
