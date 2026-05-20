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

# Migrate personal git identity before symlinking shared gitconfig
if [ ! -f "$HOME/.gitconfig.local" ] && [ -f "$HOME/.gitconfig" ]; then
  echo "  migrating git identity to ~/.gitconfig.local..."
  for key in user.name user.email user.signingkey commit.gpgsign; do
    value=$(git config --file "$HOME/.gitconfig" "$key" 2>/dev/null)
    [ -n "$value" ] && git config --file "$HOME/.gitconfig.local" "$key" "$value"
  done
  echo "  created: ~/.gitconfig.local"
fi

link gitconfig .gitconfig

mkdir -p "$HOME/.claude"
ln -sf "$DOTFILES/claude.md" "$HOME/.claude/CLAUDE.md"
echo "  linked: $HOME/.claude/CLAUDE.md"

echo ""
echo "Done. Reload your shell: source ~/.zshrc"
echo "Machine-specific config goes in ~/.zshrc.local (not tracked by git)"
echo "Personal git config (name, email) goes in ~/.gitconfig.local (not tracked by git)"
