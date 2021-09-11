#!/bin/bash
echo "---installing terraform---"
terraformVersion="0.12.29"
sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo sh -c "gpg --dearmor > /etc/apt/trusted.gpg.d/hashicorp.gpg"
echo "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update
sudo apt-get install -y terraform
echo "---terraform done---"
