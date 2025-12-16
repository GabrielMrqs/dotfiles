#!/usr/bin/env bash

set -e

echo "🔗 Linking Hyprland configs..."
ln -sf ~/dotfiles/hypr ~/.config/hypr

echo "🔗 Linking Waybar configs..."
ln -sf ~/dotfiles/waybar ~/.config/waybar

echo "✅ Dotfiles installed successfully"
