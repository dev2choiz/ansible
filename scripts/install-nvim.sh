#!/bin/bash
set -e

STARTTIME=$(date +%s)

if [ "$USER" == "root" ]; then
    echo "This script should not be run as root."
    exit 1
fi

sudo apt install -y ansible make

echo "NVIM_APPNAME is set to '${NVIM_APPNAME:-nvim}'"

ansible-playbook playbook-nvim.yml

echo "Neovim has been installed with the configuration '${NVIM_APPNAME:-nvim}'."
echo "You can launch it with:"
if [ "${NVIM_APPNAME:-nvim}" = "nvim" ]; then
  echo "  nvim ."
else
  echo "  NVIM_APPNAME=${NVIM_APPNAME} nvim ."
fi
echo ""

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
