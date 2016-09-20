#!/bin/bash

# run the remaining commands as the vagrant user
# SSH_AUTH_SOCK allows for ssh agent forwarding
sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK su vagrant <<EOF

# set JAVA_HOME on login, by appending to .bashrc
echo "export JAVA_HOME=$(readlink -f /usr/bin/javac | sed 's:/bin/javac::')" >> ~/.bashrc

# clone (private) FAST repository over SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
git clone git@github.com:snlab/odlmaple.git ~/odlmaple

# change to the FAST repo
pushd ~/odlmaple

git checkout test
# install FAST, skipping tests
mvn clean install -DskipTests

popd

EOF
