theme() {
  local theme="$1"

  local target="$DOTFILES_ZSHRC_D_DIR/misc/theme/$theme.sh"
  local link="$DOTFILES_ZSHRC_D_DIR/early.d/05-current-theme.sh"

  if [[ ! -f "$target" ]]; then
    echo "Theme not found: $target"
    return 1
  fi

  ln -sf "$target" "$link"

  # Kitty theme
  ln -sf "$HOME/.config/kitty/custom-themes/${theme}.conf" "$HOME/.config/kitty/current-theme.conf"

  echo "Theme enabled: $theme"
}

_theme() {
  local files themes

  files=("$DOTFILES_ZSHRC_D_DIR/misc/theme/"*.sh)

  themes=(${files:t})
  themes=(${themes%.sh})
  compadd "${themes[@]}"
}

if whence -w compdef >/dev/null 2>&1; then
  compdef _theme theme
fi
