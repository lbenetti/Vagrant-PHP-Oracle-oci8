# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "puphpet/ubuntu1404-x64"

    config.vm.network :private_network, ip: "192.168.40.100"

    config.vm.provider :virtualbox do |vb|

        vb.name = "JoseLamp"

        # Set server memory
        vb.customize ["modifyvm", :id, "--memory", "1024"]

        # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
        # If the clock gets more than 15 minutes out of sync (due to your laptop going
        # to sleep for instance, then some 3rd party services will reject requests.
        vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

        # Prevent VMs running on Ubuntu to lose internet connection
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    end

    config.vm.provision :shell, :path => "install.sh"

    #config.vm.provision "puppet"

    config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
end
