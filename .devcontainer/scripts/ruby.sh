#!/bin/bash
echo "---installing ruby and bundler---"
rubyVersion="2.7.4-1"
sudo apt-get install -y ruby2.7=${rubyVersion} ruby2.7-dev=${rubyVersion}
sudo apt-mark hold ruby2.7 ruby2.7-dev
sudo gem install bundler
bundle install
echo "---ruby and bundler done---"
