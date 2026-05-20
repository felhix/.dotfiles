#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

DRY_RUN=false
[[ "${1:-}" == "--dry-run" || "${1:-}" == "-n" ]] && DRY_RUN=true

log()     { printf "  %s\n" "$1"; }
success() { printf "  \033[32m✓\033[0m %s\n" "$1"; }
warn()    { printf "  \033[33m⚠\033[0m %s\n" "$1"; }
error()   { printf "  \033[31m✗\033[0m %s\n" "$1"; }

run() {
  if $DRY_RUN; then
    echo "  [DRY] $*"
  else
    "$@"
  fi
}

safe_symlink() {
  local src="$1" dest="$2"
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    success "already linked: $dest"
    return
  fi
  if [[ -f "$dest" && ! -L "$dest" ]]; then
    run mv "$dest" "$dest.backup"
    warn "backed up: $dest.backup"
  fi
  run mkdir -p "$(dirname "$dest")"
  run ln -sf "$src" "$dest"
  success "linked: $dest"
}

safe_clone() {
  local repo="$1" dest="$2"
  if [[ -d "$dest" ]]; then
    success "already exists: $(basename "$dest")"
    return
  fi
  run git clone --depth=1 "$repo" "$dest"
  success "cloned: $(basename "$dest")"
}

install_macos() {
  echo ""
  echo "→ Homebrew"
  if ! command -v brew &>/dev/null; then
    log "installing Homebrew..."
    run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    success "Homebrew already installed"
  fi

  echo ""
  echo "→ CLI tools (Brewfile)"
  run brew bundle --file="$DOTFILES/Brewfile"
  success "brew bundle done"
}

install_linux() {
  echo ""
  echo "→ CLI tools"
  local missing=()
  for tool in git zsh fzf eza bat btop gh; do
    command -v "$tool" &>/dev/null || missing+=("$tool")
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    warn "missing tools: ${missing[*]}"
    warn "run: sudo apt install ${missing[*]}"
  else
    success "all CLI tools present"
  fi

  if ! command -v delta &>/dev/null; then
    warn "delta not found — download from: https://github.com/dandavison/delta/releases"
  else
    success "delta present"
  fi
}

install_ohmyzsh() {
  echo ""
  echo "→ oh-my-zsh"
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    success "already installed"
    return
  fi
  run env RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "installed"
}

install_zsh_plugins() {
  echo ""
  echo "→ zsh plugins"
  safe_clone https://github.com/zsh-users/zsh-autosuggestions    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  safe_clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  safe_clone https://github.com/Aloxaf/fzf-tab                   "$ZSH_CUSTOM/plugins/fzf-tab"
  safe_clone https://github.com/zsh-users/zsh-completions        "$ZSH_CUSTOM/plugins/zsh-completions"
}

install_symlinks() {
  echo ""
  echo "→ symlinks"
  safe_symlink "$DOTFILES/zsh/zshrc"      "$HOME/.zshrc"
  safe_symlink "$DOTFILES/git/gitconfig"  "$HOME/.gitconfig"
  safe_symlink "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
}

migrate_git_identity() {
  echo ""
  echo "→ git identity"
  if [[ -f "$HOME/.gitconfig.local" ]]; then
    success "~/.gitconfig.local already exists"
    return
  fi
  if [[ ! -f "$HOME/.gitconfig" ]]; then
    warn "no ~/.gitconfig found — skipping migration"
    warn "set user.name and user.email in ~/.gitconfig.local after install"
    return
  fi
  log "migrating git identity to ~/.gitconfig.local..."
  for key in user.name user.email user.signingkey commit.gpgsign gpg.format; do
    value=$(git config --file "$HOME/.gitconfig" "$key" 2>/dev/null || true)
    [[ -n "$value" ]] && run git config --file "$HOME/.gitconfig.local" "$key" "$value"
  done
  success "created ~/.gitconfig.local"
}

$DRY_RUN && echo "--- DRY RUN MODE ---"
echo "Installing dotfiles..."

if [[ "$OSTYPE" == "darwin"* ]]; then
  install_macos
else
  install_linux
fi

install_ohmyzsh
install_zsh_plugins
migrate_git_identity
install_symlinks

echo ""
success "Done. Reload your shell: source ~/.zshrc"
echo "  Machine-specific config → ~/.zshrc.local"
echo "  Personal git identity   → ~/.gitconfig.local"
