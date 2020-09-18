#!/bin/bash
# install tools for container standup
echo "cwd: $(pwd)"
echo "---getting tools---"
sudo apt-get update
sudo apt-get install -y jq less
# pre commit
pip install pre-commit
# tools
. .devcontainer/scripts/gcloud.sh
. .devcontainer/scripts/terraform.sh
echo "---tools done---"