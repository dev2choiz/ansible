#!/bin/bash
set -e

STARTTIME=$(date +%s)

if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

sudo apt install -y ansible make

NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
NVIM_CONFIG="${NVIM_CONFIG:-lazyvim}"
EXTRA_TAGS="${EXTRA_TAGS:-}"

echo "NVIM_APPNAME is set to '${NVIM_APPNAME}'"
echo "NVIM_CONFIG is set to '${NVIM_CONFIG}'"
echo "EXTRA_TAGS is set to '${EXTRA_TAGS}'"

TAGS="nvim,$NVIM_CONFIG"
if [ -n "$EXTRA_TAGS" ]; then
  TAGS="$TAGS,$EXTRA_TAGS"
fi

ansible-playbook playbook-nvim.yml --ask-become-pass --tags "$TAGS"

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
