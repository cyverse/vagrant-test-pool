# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_python_2_7 = <<SCRIPT
sudo apt-get update -qq && sudo apt-get install -qq python2.7
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define "ubuntu1604" do |ubuntu1604|
    ubuntu1604.vm.box = "ubuntu/xenial64"
    ubuntu1604.vm.network "private_network", ip: "10.255.255.10"
    ubuntu1604.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/authorized_keys"
    ubuntu1604.vm.provision "shell", path: "bootstrap.sh"
    ubuntu1604.vm.provision "shell", inline: $install_python_2_7
  end
  config.vm.define "ubuntu1404" do |ubuntu1404|
    ubuntu1404.vm.box = "ubuntu/trusty64"
    ubuntu1404.vm.network "private_network", ip: "10.255.255.11"
    ubuntu1404.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/authorized_keys"
    ubuntu1404.vm.provision "shell", path: "bootstrap.sh"
  end
  config.vm.define "ubuntu1204" do |ubuntu1204|
    ubuntu1204.vm.box = "ubuntu/precise64"
    ubuntu1204.vm.network "private_network", ip: "10.255.255.12"
    ubuntu1204.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/authorized_keys"
    ubuntu1204.vm.provision "shell", path: "bootstrap.sh"
  end
  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "centos/7"
    centos7.vm.network "private_network", ip: "10.255.255.20"
    centos7.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/authorized_keys"
    centos7.vm.provision "shell", path: "bootstrap.sh"
  end
  config.vm.define "centos6" do |centos6|
    centos6.vm.box = "centos/6"
    centos6.vm.network "private_network", ip: "10.255.255.21"
    centos6.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/authorized_keys"
    centos6.vm.provision "shell", path: "bootstrap.sh"
  end
#  config.vm.define "centos5" do |centos5|
#    centos5.vm.box = "hajee/centos-5.10-x86_64"
#    centos5.vm.network "private_network", ip: "10.255.255.22"
#  end

end
