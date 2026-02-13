#!/usr/bin/env bash

theme="${DOTFILES_THEME:-gruvbox}"

case "$theme" in
"gruvbox")
  tmux set -g @powerkit_theme "custom"
  tmux set -g @powerkit_custom_theme_path "$HOME/.config/tmux/themes/powerkit/gruvbox.sh"
  ;;
*)
  tmux set -g @powerkit_theme "custom"
  tmux set -g @powerkit_custom_theme_path "$HOME/.config/tmux/themes/powerkit/custom.sh"
  ;;
esac
