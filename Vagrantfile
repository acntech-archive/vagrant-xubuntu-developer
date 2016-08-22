# -*- mode: ruby -*-
# vi: set ft=ruby :

$user = "acntech"

Vagrant.configure(2) do |config|

  # Name of Vagrant Box
  config.vm.box = "acntech/xubuntu-basic"

  # Don't generate new SSH key, but use the default insecure key
  config.ssh.insert_key = false
  config.ssh.username = $user

  # Synced folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/var/" + $user, owner: $user, group: $user

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM
    vb.memory = "2048"

    # Name to display in Virtualbox
    vb.name = "AcnTech Xubuntu Developer"
  end

  # Enable provisioning with puppet
  config.vm.provision "puppet" do |puppet|
    puppet.environment_path = "puppet/environments"
    puppet.environment = "dev"
    puppet.module_path = "puppet/modules"
    puppet.options = "--verbose --debug"
  end

  # Update packages
  config.vm.provision "shell", inline: "apt-get -y update && apt-get -y upgrade"

  # Make sure IntelliJ dekstop icon is present
  config.vm.provision "file", source: "puppet/modules/intellij/files/intellij.desktop", destination: "~/.local/share/applications/intellij.desktop"

end
