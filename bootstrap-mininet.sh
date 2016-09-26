#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y git
if [ ! -d "/home/vagrant/mininet" ]; then
 sudo -u vagrant git clone git://github.com/mininet/mininet
fi
/home/vagrant/mininet/util/install.sh -a

sudo -u vagrant mkdir -p /home/vagrant/bin
sudo cp /vagrant/utils/mininetSim /usr/local/bin/
sudo echo 'sudo mn --controller=remote,ip=127.0.0.1 --mac --custom=/home/vagrant/Maple_Topo_Scripts/exampletopo.py --topo=mytopo --switch=ovs,protocols=OpenFlow13' > /usr/local/bin/start_maple_mininet
sudo chmod a+x /usr/local/bin/start_maple_mininet
echo "Mininet has been installed successfully!"
