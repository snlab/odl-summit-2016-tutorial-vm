#!/bin/bash

su vagrant <<EOF

# Install Maple binary, *.tar.gz is reserved for staring a Maple from very clean stage
bash <(curl https://raw.githubusercontent.com/snlab/Maple-release/master/utils/install.sh -L)

curl -sSL https://raw.githubusercontent.com/snlab/Maple-release/master/utils/start_maple.sh -o /home/vagrant/bin/maple
chmod +x /home/vagrant/bin/maple
ln -s /home/vagrant/bin/maple /home/vagrant/bin/start_maple_controller

echo "Maple App has been installed successfully!"
EOF
