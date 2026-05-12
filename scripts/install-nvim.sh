#!/bin/bash

source ./scripts/lib/helpers.sh

STARTTIME=$(date +%s)

ensure_not_root
install_ansible

ANSIBLE_PATH="$HOME/.local/bin"

NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
NVIM_CONFIG="${NVIM_CONFIG:-lazyvim}"

parse_common_args "$@"

TAGS_LIST=("nvim" "$NVIM_CONFIG" "${TAGS_LIST[@]}")

ALL_TAGS=($(merge_tags_and_forced_roles))

TAGS_ARG=$(build_tags_arg "${ALL_TAGS[@]}")
FORCE_ARGS=$(build_force_extra_args)
BECOME_ARG=$(build_become_arg)

CMD="$ANSIBLE_PATH/ansible-playbook playbook-nvim.yml $TAGS_ARG $FORCE_ARGS $BECOME_ARG"

echo ""
echo "NVIM_APPNAME='${NVIM_APPNAME}'"
echo "NVIM_CONFIG='${NVIM_CONFIG}'"
echo "$CMD"
echo ""

eval "$CMD"

echo "Neovim has been installed with configuration '${NVIM_APPNAME}'."
echo "You can launch it with:"
if [ "$NVIM_APPNAME" = "nvim" ]; then
  echo "  nvim ."
else
  echo "  NVIM_APPNAME=${NVIM_APPNAME} nvim ."
fi
echo ""

ENDTIME=$(date +%s)
echo "Execution duration: $((ENDTIME - STARTTIME))s"
