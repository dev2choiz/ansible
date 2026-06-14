#!/usr/bin/env bash

theme="${DOTFILES_THEME:-gruvbox}"

case "$theme" in
"gruvbox")
  tmux set -g @powerkit_theme "custom"
  tmux set -g @powerkit_custom_theme_path "$HOME/.config/tmux/themes/powerkit/gruvbox.sh"
  tmux set -g @powerkit_plugin_group_colors "pane-border-active,good-base-darker,info-base-darker"
  ;;
"catppuccin")
  tmux set -g @powerkit_theme "custom"
  tmux set -g @powerkit_custom_theme_path "$HOME/.config/tmux/themes/powerkit/catppuccin.sh"
  tmux set -g @powerkit_plugin_group_colors "session-copy-bg,statusbar-fg,error-base-darker"
  ;;
*)
  tmux set -g @powerkit_theme "custom"
  tmux set -g @powerkit_custom_theme_path "$HOME/.config/tmux/themes/powerkit/custom.sh"
  ;;
esac
