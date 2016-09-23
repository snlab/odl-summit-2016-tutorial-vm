#!/bin/bash

su vagrant <<EOF

rm -rf /home/vagrant/tutorial/maple-archetype
pushd /home/vagrant/tutorial
git clone https://github.com/snlab/maple-archetype.git

# Install Maple Archetype
pushd /home/vagrant/tutorial/maple-archetype
mvn clean install -DskipTests
popd
rm -rf /home/vagrant/tutorial/maple-archetype

# Install Maple binary, *.tar.gz is reserved for staring a Maple from very clean stage
curl -LO https://github.com/snlab/Maple-release/archive/1.0.0.tar.gz
tar xvf 1.0.0.tar.gz
# the name of decompress 1.0.0.tar.gz would be Maple-release-1.0.0
mv 1.0.0.tar.gz Maple-release-1.0.0.tar.gz
popd

echo "Maple App has been installed successfully!"
EOF
