VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu Server 14.04.5 LTS Trusty Tahr (64-bit) with docker pre-installed
  config.vm.box = "williamyeh/ubuntu-trusty64-docker"

  # forward ssh agent and X11
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  # Create a forwarded port
  config.vm.network "forwarded_port", guest: 6633, host: 6633 #ODL openflow
  config.vm.network "forwarded_port", guest: 8080, host: 8080 #ODL restconf
  config.vm.network "forwarded_port", guest: 8181, host: 8181 #ODL dlux
  config.vm.network "forwarded_port", guest: 8101, host: 8101 #ODL ssh
  config.vm.network "forwarded_port", guest: 3000, host: 3000 #SDN IDE
  for i in 9000..9100
    config.vm.network :forwarded_port, guest: i, host: i #SDN IDE
  end
  config.vm.network "forwarded_port", guest: 8081, host: 8081 #docker cadvisor

# configure virtualbox provider
  config.vm.provider "virtualbox" do |v|
    v.name = "FASTMaple"
    v.gui = true
    v.memory = "2048"
  end

  config.vm.synced_folder "utils", "/home/vagrant/tutorial/utils"
  # run ./bootstrap.sh
  config.vm.provision :shell, :path => "bootstrap-mininet.sh"
  config.vm.provision :shell, :path => "bootstrap-fast.sh"
  config.vm.provision :shell, :path => "bootstrap-devopen.sh"
  config.vm.provision :shell, :path => "bootstrap-maple.sh"
  config.vm.provision :shell, :path => "bootstrap-docker.sh"
end
