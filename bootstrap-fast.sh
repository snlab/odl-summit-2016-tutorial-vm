#!/bin/bash

# FAST requires maven 3.3+ and java 8+
# on Ubuntu 16.04, default-jdk and maven packages satisfy these requirements
#apt-get update
#apt-get install -y git default-jdk maven

# log package version information
git --version
java -version
mvn --version

# run the remaining commands as the vagrant user
su vagrant <<EOF

# set JAVA_HOME on login, by appending to .bashrc
echo "export JAVA_HOME=$(readlink -f /usr/bin/javac | sed 's:/bin/javac::')" >> ~/.bashrc

# create tutorial directory
if [ ! -d "/home/vagrant/tutorial" ];then
  mkdir tutorial
fi
pushd ~/tutorial

# clone public repository
if [ ! -f "~/tutorial/fast-system-features-1.0.3-Beryllium-SR3.kar" ] || [! -d "~/.m2"]; then
  if [ ! -d "~/tutorial/TempFastSystemKar" ]; then
    git clone https://github.com/ShawnLinLoveLife/TempFastSystemKar.git ~/tutorial/TempFastSystemKar
  fi

  pushd ~/tutorial/TempFastSystemKar
# copy m2 to ~/.m2/, settings.xml is included in m2.zip
  if [ ! -d "~/.m2" ]; then
    if [ ! -d "./.m2" ]; then
      unzip m2.zip > /dev/null
    fi
    cp -r .m2 ~/
  fi
  if [ ! -f "~/tutorial/fast-system-features-1.0.3-Beryllium-SR3.kar" ]; then
    cp fast-system-features-1.0.3-Beryllium-SR3.kar ~/tutorial
  fi
  popd
fi

# Download ODL Beryllium SR3, and unzip it
if [ ! -d "/home/vagrant/tutorial/distribution-karaf-0.4.3-Beryllium-SR3" ];then
  if [ ! -f "/home/vagrant/tutorial/distribution-karaf-0.4.3-Beryllium-SR3.zip" ]; then
     wget --progress=bar:force https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/integration/distribution-karaf/0.4.3-Beryllium-SR3/distribution-karaf-0.4.3-Beryllium-SR3.zip 
  fi
  unzip distribution-karaf-0.4.3-Beryllium-SR3.zip > /dev/null  
fi

# Remove useless files
rm -r TempFastSystemKar
popd
echo "FAST system has been installed successfully!"
EOF
