#!/bin/bash

STARTTIME=$(date +%s)

if [ "$USER" == "root" ]; then
    echo "This script should not be run as root."
    exit 1
fi

sudo apt install -y ansible make
ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml --tags nvim

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
