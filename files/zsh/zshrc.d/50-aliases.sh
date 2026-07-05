theme() {
  local target="$DOTFILES_ZSHRC_D_DIR/misc/theme/$1.sh"
  local link="$DOTFILES_ZSHRC_D_DIR/early.d/05-current-theme.sh"

  if [[ ! -f "$target" ]]; then
    echo "Theme not found: $target"
    return 1
  fi

  ln -sf "$target" "$link"
  echo "Theme enabled: $1"
}

_theme() {
  local files themes

  files=("$DOTFILES_ZSHRC_D_DIR/misc/theme/"*.sh)

  themes=(${files:t})
  themes=(${themes%.sh})
  compadd "${themes[@]}"
}

compdef _theme theme
