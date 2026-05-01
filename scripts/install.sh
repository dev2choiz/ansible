#!/bin/bash
set -euo pipefail

STARTTIME=$(date +%s)

USER=${USER:-$(whoami)}
if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

./scripts/install-ansible.sh

ANSIBLE_PATH="$HOME/.local/bin"

$ANSIBLE_PATH/ansible-galaxy install -r requirements.yml

TAGS_LIST=()
FORCE_LIST=()

# Parse command line arguments
# Supported:
# --tags=role1,role2
# --force=role1,role2
for arg in "$@"; do
  case "$arg" in
  --tags=*)
    IFS=',' read -ra ADDR <<<"${arg#--tags=}"
    TAGS_LIST+=("${ADDR[@]}")
    ;;
  --force=*)
    IFS=',' read -ra ADDR <<<"${arg#--force=}"
    FORCE_LIST+=("${ADDR[@]}")
    ;;
  esac
done

# Merge tags and forced roles
# Forced roles are automatically added to execution tags
ALL_TAGS=("${TAGS_LIST[@]}")

for f in "${FORCE_LIST[@]}"; do
  if [[ ! " ${ALL_TAGS[*]} " =~ " ${f} " ]]; then
    ALL_TAGS+=("$f")
  fi
done

# Build Ansible tags argument string
TAGS_ARG=""
if [ ${#ALL_TAGS[@]} -gt 0 ]; then
  TAGS_ARG="--tags $(
    IFS=,
    echo "${ALL_TAGS[*]}"
  )"
fi

# Build Ansible extra variables argument
# Passing forced roles to Ansible
EXTRA_ARGS=""
if [ ${#FORCE_LIST[@]} -gt 0 ]; then
  FORCE_STR=$(
    IFS=,
    echo "${FORCE_LIST[*]}"
  )
  EXTRA_ARGS="-e force_roles=\"$FORCE_STR\""
fi

# Ask the password if not provided in vars/main.yml
if [ ! -f "./vars/main.yml" ] || ! grep -Eq "^ *ansible_become_password:" "./vars/main.yml"; then
  EXTRA_ARGS="${EXTRA_ARGS} --ask-become-pass"
fi

echo "$ANSIBLE_PATH/ansible-playbook playbook.yml $TAGS_ARG $EXTRA_ARGS"
$ANSIBLE_PATH/ansible-playbook playbook.yml $TAGS_ARG $EXTRA_ARGS

[ -z "$TAGS_ARG" ] && [ -f ./custom/install.sh ] && ./custom/install.sh

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
