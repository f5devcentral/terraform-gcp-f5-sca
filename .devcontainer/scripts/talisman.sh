#!/bin/bash
echo "---installing talisman---"
# talisman
talismanVersion="1.22.0"
sudo curl -sLo /usr/local/bin/talisman https://github.com/thoughtworks/talisman/releases/download/v${talismanVersion}/talisman_linux_amd64
sudo chmod 0755 /usr/local/bin/talisman
echo "---talisman done---"
