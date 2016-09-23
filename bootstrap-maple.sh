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
curl -L -o maple-latest.zip $(curl -s https://api.github.com/repos/snlab/Maple-release/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
unzip maple-latest.zip
rm -f maple-latest.zip
popd

echo "Maple App has been installed successfully!"
EOF
