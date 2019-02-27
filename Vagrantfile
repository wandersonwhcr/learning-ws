Vagrant.configure("2") do |config|
    config.vm.box = "debian/contrib-stretch64"

    config.vm.provider "virtualbox" do |virtualbox|
        virtualbox.cpus   = 1
        virtualbox.memory = 256
    end

    config.vm.provision "shell" do |shell|
        shell.path = "vagrant/shell/default.sh"
    end
end
