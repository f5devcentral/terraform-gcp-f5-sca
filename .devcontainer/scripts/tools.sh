#!/bin/bash
# install tools for container standup
# shellcheck disable=SC1091
SCRIPT_DIR="$(dirname "$(readlink -e "$0")")"
echo "cwd: $(pwd)"
echo "---getting tools---"
sudo apt-get update
sudo apt-get install -y apt-transport-https curl wget lsb-release ca-certificates gnupg jq less
# tools
. "${SCRIPT_DIR}/gcloud.sh"
. "${SCRIPT_DIR}/talisman.sh"
. "${SCRIPT_DIR}/terraform.sh"
. "${SCRIPT_DIR}/terraformDocs.sh"
. "${SCRIPT_DIR}/preCommit.sh"
. "${SCRIPT_DIR}/ruby.sh"
echo "---tools done---"
