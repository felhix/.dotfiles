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

### 5. macOS only — persist SSH key passphrase
```sh
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

## Machine-specific config
Put anything machine-specific in `~/.zshrc.local` — sourced automatically, not tracked by git.
