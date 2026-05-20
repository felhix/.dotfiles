#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dest="$HOME/$2"

  if [ -f "$dest" ] && [ ! -L "$dest" ]; then
    echo "  backup: $dest -> $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  ln -sf "$src" "$dest"
  echo "  linked: $dest"
}

echo "Installing dotfiles..."

link zshrc .zshrc
link gitconfig .gitconfig

mkdir -p "$HOME/.claude"
ln -sf "$DOTFILES/claude.md" "$HOME/.claude/CLAUDE.md"
echo "  linked: $HOME/.claude/CLAUDE.md"

echo ""
echo "Done. Reload your shell: source ~/.zshrc"
echo "Machine-specific config goes in ~/.zshrc.local (not tracked by git)"
echo "Personal git config (name, email) goes in ~/.gitconfig.local (not tracked by git)"
