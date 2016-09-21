#!/bin/bash

# FAST requires maven 3.3+ and java 8+
# run the remaining commands as the vagrant user
su vagrant <<EOF

rm /home/vagrant/maple-archetype  
git clone https://github.com/snlab/maple-archetype.git
pushd /home/vagrant/maple-archetype
mvn clean install -DskipTests
popd


echo "Maple App has been installed successfully!"
EOF
