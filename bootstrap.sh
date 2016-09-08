#!/bin/bash

# FAST requires maven 3.3+ and java 8+
# on Ubuntu 16.04, default-jdk and maven packages satisfy these requirements
apt-get update
apt-get install -y git default-jdk maven

# log package version information
git --version
java -version
mvn --version

# run the remaining commands as the vagrant user
sudo SSH_AUTH_SOCK=$SSH_AUTH_SOCK su vagrant <<EOF

# set JAVA_HOME on login, by appending to .bashrc
echo "export JAVA_HOME=$(readlink -f /usr/bin/javac | sed 's:/bin/javac::')" >> ~/.bashrc

# clone public repository
if [ ! -d "~/TempFastSystemKar" ]; then
  git clone https://github.com/ShawnLinLoveLife/TempFastSystemKar.git ~/TempFastSystemKar
fi

# copy m2 to ~/.m2/, settings.xml is included in m2.zip
pushd ~/TempFastSystemKar
if [ ! -d "~/.m2" ]; then
  if [ ! -d "./.m2" ]; then
    unzip m2.zip > /dev/null
  fi
  cp -r .m2 ~/
fi

# copy fast.kar into ~/ 
if [ ! -f "~/fast-system-features-1.0.3-Beryllium-SR3.kar" ]; then
cp fast-system-features-1.0.3-Beryllium-SR3.kar ~/
fi
popd

# Download ODL Beryllium SR3, and unzip it
if [ ! -f "~/distribution-karaf-0.4.3-Beryllium-SR3.zip" ]; then
  wget --progress=bar:force https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/integration/distribution-karaf/0.4.3-Beryllium-SR3/distribution-karaf-0.4.3-Beryllium-SR3.zip
fi

if [ ! -d "~/distribution-karaf-0.4.3-Beryllium-SR3 ]; then
  unzip distribution-karaf-0.4.3-Beryllium-SR3.zip > /dev/null
fi

# Remove useless files
rm distribution-karaf-0.4.3-Beryllium-SR3.zip
rm -r TempFastSystemKar

EOF
