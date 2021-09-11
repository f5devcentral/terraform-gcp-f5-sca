#!/bin/bash
echo "---installing pre-commit---"
# pre-commit - requires a python3 runtime to be installed
sudo apt-get install -y pip
pip install pre-commit
# Allowing pre-commit to override the hook from volume mount may cause problems
# when user switches back to non-container use of folder. Instead create a set
# of hooks in a container-only folder and override the copied .gitconfig in post
# attach step
mkdir -p ~/.container
git config --global init.templatedir ~/.container
pre-commit init-templatedir ~/.container
rm -f ~/.gitconfig
echo "---pre-commit done---"
