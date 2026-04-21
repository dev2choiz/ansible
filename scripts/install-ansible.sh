#!/bin/bash
set -euo pipefail

if [[ -x "$HOME/.local/bin/pipx" && -x "$HOME/.local/bin/ansible" ]]; then
  echo "pipx and ansible already installed, skip"
  exit 0
fi

sudo apt install -y pipx

# Install pipx inside pipx itself for the latest version
pipx install pipx

# remove the pipx installed by apt
sudo apt remove --purge -y pipx

$HOME/.local/bin/pipx ensurepath

# Install ansible using pipx for the latest version
$HOME/.local/bin/pipx install --include-deps ansible
