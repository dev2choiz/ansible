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
echo "Execution duration: $(($ENDTIME - $STARTTIME))s"
