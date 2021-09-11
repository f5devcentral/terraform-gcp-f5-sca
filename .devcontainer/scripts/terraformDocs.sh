#!/bin/bash
echo "---installing terraformDocs---"
# terraform docs
terraformDocsVersion="0.15.0"
sudo sh -c "curl -sL --output - https://github.com/terraform-docs/terraform-docs/releases/download/v${terraformDocsVersion}/terraform-docs-v${terraformDocsVersion}-linux-amd64.tar.gz | tar xzf - -C /usr/local/bin"
sudo chmod 0755 /usr/local/bin/terraform-docs
echo "---terraformDocs done---"
