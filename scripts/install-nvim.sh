#!/bin/bash
set -e

STARTTIME=$(date +%s)

USER=${USER:-$(whoami)}
if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

sudo apt install -y pipx
pipx install --include-deps ansible

NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
NVIM_CONFIG="${NVIM_CONFIG:-lazyvim}"
EXTRA_TAGS="${EXTRA_TAGS:-}"
ANSIBLE_EXTRA=""

TAGS="nvim,$NVIM_CONFIG"
if [ -n "$EXTRA_TAGS" ]; then
  TAGS="$TAGS,$EXTRA_TAGS"
fi

if [ ! -f "./vars/main.yml" ] || ! grep -Eq "^ *ansible_become_password:" "./vars/main.yml"; then
  ANSIBLE_EXTRA="--ask-become-pass"
fi

echo ""
echo "NVIM_APPNAME is set to '${NVIM_APPNAME}'"
echo "NVIM_CONFIG is set to '${NVIM_CONFIG}'"
echo "EXTRA_TAGS is set to '${EXTRA_TAGS}'"
echo "ANSIBLE_EXTRA is set to '${ANSIBLE_EXTRA}'"
echo "$HOME/.local/bin/ansible-playbook playbook-nvim.yml --tags \"$TAGS\" $ANSIBLE_EXTRA"
echo ""

$HOME/.local/bin/ansible-playbook playbook-nvim.yml --tags "$TAGS" $ANSIBLE_EXTRA

echo "Neovim has been installed with the configuration '${NVIM_APPNAME}'."
echo "You can launch it with:"
if [ "$NVIM_APPNAME" = "nvim" ]; then
  echo "  nvim ."
else
  echo "  NVIM_APPNAME=${NVIM_APPNAME} nvim ."
fi
echo ""

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
