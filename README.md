# dotfiles

## What's here
- `zshrc` — oh-my-zsh config (robbyrussell)
- `aliases` — shared aliases (git, docker, python, eza, bat)
- `aliases.mac` / `aliases.linux` — OS-specific
- `functions` — shell utilities (`fs`, `mkcdir`)
- `gitconfig` — git config with delta wired in as diff viewer
- `claude.md` — shared Claude Code global config

## Install on a new machine

### 1. Install oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Install zsh plugins

| Plugin | What it does |
|--------|-------------|
| zsh-autosuggestions | Grey ghost suggestion from history as you type — `→` to accept |
| zsh-syntax-highlighting | Commands turn green (valid) or red (unknown) as you type |
| fzf-tab | Tab completion becomes a fuzzy, colourful popup |
| zsh-completions | Adds tab completions for tools that zsh doesn't cover by default |

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### 3. Install CLI tools

| Tool | What it does |
|------|-------------|
| eza | Pretty `ls` — colours, icons, git status per file |
| bat | Pretty `cat` — syntax highlighting, line numbers |
| fzf | `ctrl+r` fuzzy history search, `ctrl+t` fuzzy file find |
| btop | Beautiful system monitor (CPU, RAM, processes) |
| tldr | Practical command examples — `tldr git` beats `man git` |
| delta | Syntax-highlighted git diffs with side-by-side view |

**Linux (Ubuntu):**
```sh
sudo apt install eza bat fzf btop tldr
# delta: download .deb from https://github.com/dandavison/delta/releases
```

**macOS:**
```sh
brew install eza bat fzf btop tldr git-delta
```

### 4. Clone and install dotfiles
```sh
git clone git@github.com:felhix/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

The install script will automatically migrate your git identity (`name`, `email`, `signingkey`) to `~/.gitconfig.local`.

### 5. Install a Nerd Font

Required for icons in `eza`. Using **0xProto Nerd Font** — change to taste from [nerdfonts.com](https://www.nerdfonts.com).

**macOS (iTerm2):**
```sh
brew install --cask font-0xproto-nerd-font
```
Then iTerm2 → Preferences → Profiles → Text → Font → `0xProto Nerd Font`.

**Linux:** download from nerdfonts.com, extract to `~/.local/share/fonts/`, run `fc-cache -fv`, set in terminal preferences.

### 6. macOS only — persist SSH key passphrase
```sh
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

## Machine-specific config
Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
