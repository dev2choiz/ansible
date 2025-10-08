#!/bin/bash

STARTTIME=$(date +%s)

if [ "$USER" == "root" ]; then
    echo "This script should not be run as root."
    exit 1
fi

if [ ! -f ./vars/main.yml ]; then
    echo "./vars/main.yml file does not exists. Please create it by taking as example the file ./vars/main.yml.example"
    exit 1
fi

sudo apt install -y make ansible
ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml

if [ -f ./custom/install.sh ]; then
  ./custom/install.sh
fi

ENDTIME=$(date +%s)
echo "Execution duration: $(($ENDTIME - $STARTTIME))s"
