#!/bin/bash

su vagrant <<EOF

#rm -rf /home/vagrant/tutorial/maple-archetype
#pushd /home/vagrant/tutorial
#git clone https://github.com/snlab/maple-archetype.git

# Install Maple Archetype
#pushd /home/vagrant/tutorial/maple-archetype
#mvn clean install -DskipTests
#popd
#rm -rf /home/vagrant/tutorial/maple-archetype

# Install Maple binary, *.tar.gz is reserved for staring a Maple from very clean stage
pushd /home/vagrant/tutorial
if [ -f "/home/vagrant/tutorial/maple-latest.zip" ]; then
  rm -f maple-latest.zip
fi
curl -L -o maple-latest.zip $(curl -s https://api.github.com/repos/snlab/Maple-release/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
if [ -d "/home/vagrant/tutorial/maple-latest" ]; then
  rm -r maple-latest
fi
unzip maple-latest.zip
popd

cp /vagrant/utils/maple /home/vagrant/bin/maple

echo "Maple App has been installed successfully!"
EOF
