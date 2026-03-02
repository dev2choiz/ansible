#!/bin/bash
set -euo pipefail

STARTTIME=$(date +%s)

if [ "$USER" = "root" ]; then
  echo "This script should not be run as root."
  exit 1
fi

sudo apt install -y make ansible
ansible-galaxy install -r requirements.yml

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
    for t in "${ADDR[@]}"; do
      TAGS_LIST+=("$t")
    done
    ;;
  --force=*)
    IFS=',' read -ra ADDR <<<"${arg#--force=}"
    for f in "${ADDR[@]}"; do
      FORCE_LIST+=("$f")
    done
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
  EXTRA_ARGS="-e force_roles=\" ${FORCE_LIST[*]} \""
fi

ansible-playbook playbook.yml $TAGS_ARG "${EXTRA_ARGS}"

[ -z "$TAGS_ARG" ] && [ -f ./custom/install.sh ] && ./custom/install.sh

ENDTIME=$(date +%s)
DURATION=$((ENDTIME - STARTTIME))
echo "Execution duration: ${DURATION}s"
