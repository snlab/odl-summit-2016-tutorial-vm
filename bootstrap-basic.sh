#!/bin/bash

# Basic environment requires maven 3.3+ and java 8+

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
mkdir -p /home/vagrant/tutorial

# setup .m2 environment
mkdir -p /home/vagrant/.m2
curl -L -o m2.zip $(curl -s https://api.github.com/repos/snlab/m2-odl-summit/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
unzip m2.zip
cp -r m2/* /home/vagrant/.m2/
rm -f m2.zip

EOF
