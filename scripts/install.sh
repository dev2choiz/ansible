#!/bin/bash

set -euo pipefail

source ./scripts/lib/helpers.sh

STARTTIME=$(date +%s)

ensure_not_root
install_ansible

ANSIBLE_PATH="$HOME/.local/bin"

$ANSIBLE_PATH/ansible-galaxy install -r requirements.yml
parse_common_args "$@"

ALL_TAGS=($(merge_tags_and_forced_roles))

TAGS_ARG=$(build_tags_arg "${ALL_TAGS[@]}")
FORCE_ARGS=$(build_force_extra_args)
BECOME_ARG=$(build_become_arg)

CMD="$ANSIBLE_PATH/ansible-playbook playbook.yml $TAGS_ARG $FORCE_ARGS $BECOME_ARG"

echo "$CMD"
echo ""

eval "$CMD"

[ -z "$TAGS_ARG" ] && [ -f ./custom/install.sh ] && ./custom/install.sh

ENDTIME=$(date +%s)
echo "Execution duration: $((ENDTIME - STARTTIME))s"
