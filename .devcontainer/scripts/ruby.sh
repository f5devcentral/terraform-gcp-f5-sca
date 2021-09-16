#!/bin/bash
echo "---installing ruby and bundler---"
rubyVersion="2.7"
sudo apt-get install -y ruby${rubyVersion} ruby-dev
sudo apt-mark hold ruby${rubyVersion} ruby-dev
sudo gem install bundler
echo "---ruby and bundler done---"
