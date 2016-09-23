#!/bin/bash

# run the remaining commands as the vagrant user
su vagrant <<EOF

# clone public repository
if [ ! -f "~/tutorial/fast-system-features-1.0.3-Beryllium-SR3.kar" ]||[ ! -d "~/.m2" ]; then
  if [ ! -d "~/tutorial/TempFastSystemKar" ]; then
    git clone https://github.com/ShawnLinLoveLife/TempFastSystemKar.git ~/tutorial/TempFastSystemKar
  fi
  pushd ~/tutorial/TempFastSystemKar
# copy m2 to ~/.m2/, settings.xml is included in m2.zip
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
