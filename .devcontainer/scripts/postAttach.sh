#!/bin/sh
echo "---executing postAttach---"
# Allowing pre-commit to override the hook from volume mount may cause problems
# when user switches back to non-container use of folder. Instead create a set
# of hooks in a container-only folder and override the copied .gitconfig in post
# attach step
git config --global core.hookspath ~/.container/hooks
echo "---postAttach done---"
