#!/bin/bash

set -euo pipefail

LAZYVIM_REPO="https://github.com/LazyVim/starter.git"
ANSIBLE_DIR="$HOME/System/ansible"
NVIM_DIR="$HOME/.config/nvim"

cd "$ANSIBLE_DIR"

echo "Installing Kitty configuration..."
mkdir -p "$HOME/.config"
cp -Rf ./files/kitty/. "$HOME/.config/kitty/"

echo "Installing tmux themes..."
rm -rf "$HOME/.config/tmux/themes"
mkdir -p "$HOME/.config/tmux"
cp -R ./files/tmux/themes "$HOME/.config/tmux/"
cp -f ./files/tmux/tmux.conf "$HOME/.config/tmux/tmux.conf"

echo "Installing Powerlevel10k configuration..."
mkdir -p "$HOME/System/zsh"
cp -f ./files/zsh/.p10k.zsh "$HOME/System/zsh/.p10k.zsh"

echo "Installing p10k overrides..."
mkdir -p "$HOME/System/zsh/zshrc.d"
cp -f ./files/zsh/zshrc.d/early.d/00-p10k-overrides.zsh \
  "$HOME/System/zsh/zshrc.d/20-p10k-overrides.sh"

echo "Removing existing Neovim configuration..."
rm -rf "$NVIM_DIR"

echo "Cloning LazyVim starter..."
git clone --depth=1 "$LAZYVIM_REPO" "$NVIM_DIR"

echo "Installing LazyVim configuration..."
cp -R "$ANSIBLE_DIR/files/nvim/lazyvim_config/." "$NVIM_DIR/"

echo
echo "Done."
