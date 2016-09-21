#!/bin/bash

# Install base
apt-get update
apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs tmux

# Install Node.js
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs

# run the remaining commands as the vagrant user
su vagrant <<EOF

pushd /home/vagrant/tutorial/
# Install Cloud9
git clone https://github.com/fno2010/core.git -b devopen ./cloud9
./cloud9/scripts/install-sdk.sh

# Tweak standlone.js conf
sed -i -e 's_127.0.0.1_0.0.0.0_g' ./cloud9/configs/standalone.js

# Install plugins
pushd /home/vagrant/tutorial/cloud9/plugins
if [ ! -d "snlab.devopen.newresource" ]; then
  git clone https://github.com/snlab/snlab.devopen.newresource
else
  pushd snlab.devopen.newresource
  git pull
  popd
fi
if [ ! -d "snlab.devopen.controller" ]; then
  git clone https://github.com/snlab/snlab.devopen.controller
  if [ ! -d "/home/vagrant/bin" ]; then
    mkdir -p /home/vagrant/bin
    export PATH=$PATH:/home/vagrant/bin
  fi
  pushd /home/vagrant/bin
  npm install ssh2 && npm install scp2
  popd
  cp ./snlab.devopen.controller/deploy.js /home/vagrant/bin/deploy
else
  pushd snlab.devopen.controller
  git pull
  popd
fi
if [ ! -d "snlab.devopen.server" ]; then
  git clone https://github.com/snlab/snlab.devopen.server
else
  pushd snlab.devopen.server
  git pull
  popd
fi
if [ ! -d "snlab.devopen.topoeditor" ]; then
  git clone https://github.com/snlab/snlab.devopen.topoeditor
else
  pushd snlab.devopen.topoeditor
  git pull
  popd
fi
if [ ! -d "cloud9-docker" ]; then
  git clone https://github.com/fno2010/cloud9-docker.git -b devopen
fi
cp -fr /home/vagrant/tutorial/cloud9/plugins/cloud9-docker/conf/test-config.js /home/vagrant/tutorial/cloud9/configs/
cp -fr /home/vagrant/tutorial/cloud9/plugins/cloud9-docker/conf/client-workspace-test.js /home/vagrant/tutorial/cloud9/configs/
popd

# Add workspace
if [ ! -d "/home/vagrant/tutorial/workspace" ]; then
  mkdir /home/vagrant/tutorial/workspace
fi

# Add start cloud9
echo "nodejs /home/vagrant/tutorial/cloud9/server.js test-config -s standalone --workspacetype=test -l 0.0.0.0 -p 9000 -w /home/vagrant/tutorial/workspace" > /home/vagrant/tutorial/cloud9/start.sh

sudo chmod 755 /home/vagrant/tutorial/cloud9/start.sh
popd

# Install express, ssh2, body-parser
pushd /home/vagrant/tutorial/cloud9
npm install body-parser
npm install express
npm install ssh2
npm install sqlite3
npm install request
popd
EOF

# Clean up APT when done.
sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo "devopen has been installed sucessfully."
