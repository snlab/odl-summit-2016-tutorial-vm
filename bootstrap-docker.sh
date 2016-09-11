#!/bin/bash

# run the remaining commands as the vagrant user

# install docker
answer=$(dpkg -s docker-engine|grep installed)

if [ "" != "$answer" ]; then
  echo "docker has been installed successfully!"
  exit 0
fi
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
  sudo touch /etc/apt/sources.list.d/docker.list
  sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
fi
sudo apt-get update
sudo apt-get purge lxc-docker
apt-cache policy docker-engine
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-engine
echo "docker has been installed successfully!"
