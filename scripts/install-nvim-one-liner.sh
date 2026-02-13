#!/bin/bash
set -e

if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

sudo apt install -y git

# Temporary folder for cloning
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo "Cloning repository into $TMP_DIR..."
git clone --depth 1 https://github.com/dev2choiz/ansible.git "$TMP_DIR"

cd "$TMP_DIR"

./scripts/install-nvim.sh
