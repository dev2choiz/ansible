#!/bin/bash

set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script can only be run on macOS."
  exit 1
fi

LAZYVIM_REPO="https://github.com/LazyVim/starter.git"
ANSIBLE_DIR="$HOME/System/ansible"
NVIM_DIR="$HOME/.config/nvim"

DOTFILES_P10K_PATH=$HOME/System/zsh/.p10k.zsh
DOTFILES_ZSH_COMMON_DIR=$HOME/System/zsh/common

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
cp -f ./files/zsh/.p10k.zsh "$DOTFILES_P10K_PATH"

echo "Installing zshrc.d ..."
rm -rf "$DOTFILES_ZSH_COMMON_DIR"
mkdir -p "$DOTFILES_ZSH_COMMON_DIR"
cp -R ./files/zsh/zshrc.d "$DOTFILES_ZSH_COMMON_DIR/"

echo "Removing existing Neovim configuration..."
rm -rf "$NVIM_DIR"

echo "Cloning LazyVim starter..."
git clone --depth=1 "$LAZYVIM_REPO" "$NVIM_DIR"

echo "Installing LazyVim configuration..."
cp -R "$ANSIBLE_DIR/files/nvim/lazyvim_config/." "$NVIM_DIR/"

echo
echo "Done."
