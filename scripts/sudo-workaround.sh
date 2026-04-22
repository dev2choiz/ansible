#!/bin/bash
set -e

if ! sudo --version 2>&1 | grep -qi "sudo-rs"; then
  return 0
fi

# Workaround: sudo-rs introduce in ubuntu 25.10 breaks Ansible become (https://github.com/ansible/ansible/issues/85837)
# We temporarily allow passwordless sudo to bypass the prompt during execution

SUDO_FILE="/etc/sudoers.d/ansible-tmp"

cleanup() {
  echo "cleanup $SUDO_FILE..."
  sudo rm -f "$SUDO_FILE"
}
trap cleanup EXIT

echo "Activate temporary sudo with NOPASSWD"

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDO_FILE" >/dev/null
sudo chmod 0440 "$SUDO_FILE"
