#!/bin/bash
set -e

STARTTIME=$(date +%s)

if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

sudo apt install -y pipx
pipx install --include-deps ansible
sudo apt install -y python3-kubernetes
$HOME/.local/bin/ansible-galaxy install -r requirements.yml
$HOME/.local/bin/ansible-playbook playbook-k8s.yml --ask-become-pass

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
