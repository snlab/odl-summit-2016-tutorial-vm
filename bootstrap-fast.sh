#!/bin/bash

# FAST requires maven 3.3+ and java 8+

if [ ! -d "/opt/jdk" ]; then
  echo "installing jdk"
  curl -LO -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
  mkdir /opt/jdk
  tar -zxf jdk-8u101-linux-x64.tar.gz -C /opt/jdk
  rm jdk-8u101-linux-x64.tar.gz
  update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_101/bin/java 2000
  update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_101/bin/javac 2000
fi

if [ ! -d "/opt/apache-maven-3.3.9" ]; then
  echo "installing maven"
  curl -LO http://mirror.bit.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
  tar -zxf apache-maven-3.3.9-bin.tar.gz -C /opt
  ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
  rm /home/vagrant/apache-maven-3.3.9-bin.tar.gz
fi

# log package version information
git --version
java -version
mvn --version

# run the remaining commands as the vagrant user
su vagrant <<EOF

# set JAVA_HOME on login, by appending to .bashrc
echo "export JAVA_HOME=$(readlink -f /usr/bin/javac | sed 's:/bin/javac::')" >> ~/.bashrc

# create tutorial directory
if [ ! -d "/home/vagrant/tutorial" ]; then
  mkdir tutorial
fi
pushd ~/tutorial

# clone public repository
if [ ! -f "~/tutorial/fast-system-features-1.0.3-Beryllium-SR3.kar" ]||[ ! -d "~/.m2" ]; then
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
if [ ! -d "/home/vagrant/tutorial/distribution-karaf-0.4.3-Beryllium-SR3" ]; then
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
