#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES_DIR"

STOW_PACKAGES=(hypr waybar alacritty swaync fish)

PACMAN_PKGS=(
  stow
  hyprland
  hyprpaper
  hyprpicker
  hyprshot
  waybar
  alacritty
  swaync
  dmenu
  git
  fish
  # add more if needed
)

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

if ! need_cmd pacman; then
  echo "pacman not found. This installer is for Arch-based distros."
  exit 1
fi

# Install packages (only missing ones)
sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

# Apply dotfiles via stow
stow -R -t "$HOME" "${STOW_PACKAGES[@]}"

echo "Done."
echo "If needed:"
echo "  hyprctl reload"
echo "  pkill waybar; waybar &"
