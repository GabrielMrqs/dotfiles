#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES_DIR"

STOW_PACKAGES=(hypr waybar wofi alacritty swaync fish)
STOW_TARGET="$HOME"

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

# Apply dotfiles via stow.
# Packages already include a .config/ prefix, so target must be $HOME (not $HOME/.config).
stow_failures=()
stow_conflicts=()
set +e
for pkg in "${STOW_PACKAGES[@]}"; do
  stow_err="$(mktemp)"
  stow -R -t "$STOW_TARGET" "$pkg" 2>"$stow_err"
  if [[ $? -ne 0 ]]; then
    stow_failures+=("$pkg")
    stow_conflicts+=("$(rg -m 8 'cannot stow' "$stow_err" || true)")
  fi
  rm -f "$stow_err"
done
set -e

if [[ ${#stow_failures[@]} -gt 0 ]]; then
  echo "Stow completed with warnings for: ${stow_failures[*]}"
  for conflict in "${stow_conflicts[@]}"; do
    if [[ -n "$conflict" ]]; then
      echo "$conflict"
    fi
  done
  echo "Resolve conflicts or re-run with just the desired package(s)."
fi

echo "Done."
echo "If needed:"
echo "  hyprctl reload"
echo "  pkill waybar; waybar &"
