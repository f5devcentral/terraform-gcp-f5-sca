#!/bin/bash
echo "---installing gcloud---"
sudo curl -fsSLo /etc/apt/trusted.gpg.d/cloud-sdk.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/cloud-sdk.list
sudo apt-get update
sudo apt-get install -y google-cloud-sdk kubectl
echo "---gcloud done---"
