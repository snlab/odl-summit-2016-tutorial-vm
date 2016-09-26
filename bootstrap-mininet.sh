#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y git
if [ ! -d "/home/vagrant/mininet" ]; then
 sudo -u vagrant git clone git://github.com/mininet/mininet
fi
/home/vagrant/mininet/util/install.sh -a

sudo -u vagrant mkdir -p /home/vagrant/bin
sudo -u vagrant cp /vagrant/utils/mininetSim /usr/local/bin/
echo "Mininet has been installed successfully!"
