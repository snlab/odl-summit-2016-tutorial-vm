#!/bin/bash

# Install base
sudo apt-get update
sudo apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs tmux

# Install Node.js
sudo curl -sL https://deb.nodesource.com/setup | bash -
sudo apt-get install -y nodejs

pushd /home/vagrant/tutorial/    
# Install Cloud9
git clone https://github.com/fno2010/core.git -b devopen ./cloud9
./cloud9/scripts/install-sdk.sh

# Tweak standlone.js conf
sed -i -e 's_127.0.0.1_0.0.0.0_g' ./cloud9/configs/standalone.js 

# Add workspace
if [ ! -d "/home/vagrant/tutorial/workspace" ]; then
  mkdir /home/vagrant/tutorial/workspace
fi

# Clean up APT when done.
sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo "devopen has been installed sucessfully."
