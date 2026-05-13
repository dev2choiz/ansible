#!/bin/bash

set -euo pipefail

TAGS_LIST=()
FORCE_LIST=()

ensure_not_root() {
  local user="${USER:-$(whoami)}"

  if [ "$user" = "root" ]; then
    echo "This script should not be run as root."
    exit 1
  fi
}

install_ansible() {
  if [[ -x "$HOME/.local/bin/pipx" && -x "$HOME/.local/bin/ansible" ]]; then
    echo "pipx and ansible already installed, skip"
    exit 0
  fi

  sudo apt install -y pipx

  # Install pipx inside pipx itself to have the latest version
  pipx install pipx

  # remove the pipx installed by apt
  sudo apt remove --purge -y pipx

  $HOME/.local/bin/pipx ensurepath

  # Install ansible using pipx for the latest version
  $HOME/.local/bin/pipx install --force --include-deps ansible
  # $HOME/.local/bin/pipx install --force --include-deps "git+https://github.com/ansible/ansible.git@v2.20.6rc1"
}

parse_common_args() {
  for arg in "$@"; do
    case "$arg" in
    --tags=*)
      IFS=',' read -ra ADDR <<<"${arg#--tags=}"
      TAGS_LIST+=("${ADDR[@]}")
      ;;
    --force=*)
      IFS=',' read -ra ADDR <<<"${arg#--force=}"
      FORCE_LIST+=("${ADDR[@]}")
      ;;
    esac
  done
}

merge_tags_and_forced_roles() {
  local all_tags=("${TAGS_LIST[@]}")

  for f in "${FORCE_LIST[@]}"; do
    if [[ ! " ${all_tags[*]} " =~ " ${f} " ]]; then
      all_tags+=("$f")
    fi
  done

  echo "${all_tags[*]}"
}

build_tags_arg() {
  local tags=("$@")

  if [ ${#tags[@]} -eq 0 ]; then
    return
  fi

  (
    IFS=,
    echo "--tags ${tags[*]}"
  )
}

build_force_extra_args() {
  if [ ${#FORCE_LIST[@]} -eq 0 ]; then
    return
  fi

  local force_str

  force_str=$(
    IFS=,
    echo "${FORCE_LIST[*]}"
  )

  echo "-e force_roles=\"$force_str\""
}

build_become_arg() {
  if [ ! -f "./vars/main.yml" ] || ! grep -Eq "^ *ansible_become_password:" "./vars/main.yml"; then
    echo "--ask-become-pass"
  fi
}
