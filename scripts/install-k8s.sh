#!/bin/bash
set -e

STARTTIME=$(date +%s)

if [ "$USER" == "root" ]; then
    echo "This script should not be run as root."
    exit 1
fi

sudo apt install -y ansible
sudo apt install -y python3-kubernetes
ansible-galaxy install -r requirements.yml
ansible-playbook playbook-k8s.yml

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
