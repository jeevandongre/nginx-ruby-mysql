# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "stockvm"
  #config.vm.box_url = "/home/jeevan/.vagrant.d/boxes/stockvm"
  
  config.ssh.forward_agent = true

  #config.vm.network "private_network", ip: "111.111.111.111" 
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048 
    v.cpus = 2
  end
  
  config.vm.provision :chef_solo do |chef|
    chef.arguments = "-l debug"
    chef.verbose_logging = true   
    chef.add_recipe "styletag"
        
  end

  
end
