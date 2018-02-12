# AcnTech Xubuntu Developer
AcnTech Xubuntu Developer box based on [acntech/xubuntu](https://app.vagrantup.com/acntech/boxes/xubuntu) v1.1.0 with Xubuntu Desktop 16.04.3 LTS 64-bit installed on a 80 GB disk.

Created with Vagrant 2.0.2 and VirtualBox 5.6.2.

Provisioned with Puppet 5.3.

### Prerequisites
The host computer must have _Intel VT/AMD-V_ virtualization support enabled in the BIOS.

[Oracle VirtualBox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com) must also be installed on the host.

### Usage
See box on Vagrant Cloud: [acntech/xubuntu-developer](https://app.vagrantup.com/acntech/boxes/xubuntu-developer).

See code on GitHub: [acntech/vagrant-xubuntu-developer](https://github.com/acntech/vagrant-xubuntu-developer).

Create a ```Vagrantfile``` with the following content inside an empty folder:
```
Vagrant.configure("2") do |config|
  config.vm.box = "acntech/xubuntu-developer"
end
```

Start the box by issuing the following command from the command line inside the folder:
```
vagrant up
```

### Installed tools
The box has the following developer tools installed.

* Git 2.7.4
* Docker 17.05.0 Community Edition
* Docker Compose 1.18.0
* Oracle Java JDK 8u162
  * Java Security RNG changed to /dev/urandom
* Apache Maven 3.5.2
* Apache Ant 1.10.1
* JetBrains IntelliJ 2017.3.3 Community Edition
