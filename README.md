# dotfiles

## What's here
- `zshrc` — oh-my-zsh config (robbyrussell)
- `aliases` — shared aliases (git, docker, python, eza, bat)
- `aliases.mac` / `aliases.linux` — OS-specific
- `functions` — shell utilities (`fs`, `mkcdir`)
- `claude.md` — shared Claude Code global config

## Install on a new machine

### 1. Install oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Install zsh plugins
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### 3. Install CLI tools

**Linux (Ubuntu):**
```sh
sudo apt install eza bat fzf
```

**macOS:**
```sh
brew install eza bat fzf
```

### 4. Clone and install dotfiles
```sh
git clone git@github.com:felhix/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

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
