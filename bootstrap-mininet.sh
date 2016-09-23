#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y git
if [ ! -d "/home/vagrant/mininet" ]; then
 sudo -u vagrant git clone git://github.com/mininet/mininet
fi
/home/vagrant/mininet/util/install.sh -a

sudo -u vagrant cp /vagrant/mininetSim /home/vagrant/bin/
