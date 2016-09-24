# Binding cadvisor to another tcp port
sed -i -e 's/8080:8080/8081:8080/' /etc/init/cadvisor.conf

docker pull barbaracollignon/ubuntu-mininet
echo "docker has been installed successfully!"
