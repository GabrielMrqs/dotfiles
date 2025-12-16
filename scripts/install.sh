#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link_dir () {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    # se já existe, faz backup (pra não perder nada)
    local backup="${dst}.bak.$(date +%F-%H%M%S)"
    echo "📦 Backing up $dst -> $backup"
    mv "$dst" "$backup"
  fi

  echo "🔗 Linking $dst -> $src"
  ln -s "$src" "$dst"
}

link_dir "$DOTFILES_DIR/hypr"   "$HOME/.config/hypr"
link_dir "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"

echo "✅ Dotfiles installed successfully"
echo "ℹ️ Restart Hyprland session (or run: hyprctl reload; pkill waybar; waybar &)"

