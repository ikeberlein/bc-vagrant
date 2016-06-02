# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.provision :shell, path: "bootstrap.sh"

	config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :forwarded_port, guest: 3306, host: 33066
	
#	config.vm.synced_folder ".", "/home/vagrant/sync", type: "rsync", disabled: true
#	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

	config.vm.hostname = "bbc"

	config.vm.provider :virtualbox do |v|
		v.linked_clone = true
		v.memory = 1024
		v.cpus = 1
	end
end
