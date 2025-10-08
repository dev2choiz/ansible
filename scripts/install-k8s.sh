#!/bin/bash

STARTTIME=$(date +%s)

if [ "$USER" == "root" ]; then
    echo "This script should not be run as root."
    exit 1
fi

sudo apt install -y ansible
ansible-galaxy install -r requirements.yml
ansible-playbook playbook-k8s.yml

ENDTIME=$(date +%s)
echo "Execution duration: $(($ENDTIME - $STARTTIME))s"
