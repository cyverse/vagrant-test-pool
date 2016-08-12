# -*- mode: ruby -*-
# vi: set ft=ruby :

$create_vagrant_user = <<SCRIPT
# The following contains the password "vagrant" encrypted with crypt
useradd -m -p paX5EmO4EXy0I -s /bin/bash vagrant
echo "vagrant ALL=(ALL:ALL) ALL" >> /etc/sudoers
cp -r /home/ubuntu/.ssh /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh
SCRIPT

$make_vagrant_user_root = <<SCRIPT
sudo sed -i.bak 's/vagrant:x:1000:1000/vagrant:x:0:0/g' /etc/passwd
SCRIPT

$make_vagrant_user_sudoer = <<SCRIPT
sudo adduser vagrant sudo
SCRIPT

$allow_ssh_password_auth_centos_7 = <<SCRIPT
sudo sed -i.bak '/ChallengeResponseAuthentication no/d' /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
SCRIPT

$allow_ssh_password_auth_centos_6 = <<SCRIPT
sudo sed -i.bak '/ChallengeResponseAuthentication no/d' /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
sudo service sshd restart
SCRIPT

$install_python_2_7 = <<SCRIPT
sudo apt-get update -qq && sudo apt-get install -qq python2.7
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define "ubuntu1604" do |ubuntu1604|
    ubuntu1604.vm.box = "ubuntu/xenial64"
    ubuntu1604.vm.network "private_network", ip: "10.255.255.10"
    ubuntu1604.vm.provision "shell", inline: $create_vagrant_user
    ubuntu1604.vm.provision "shell", inline: $make_vagrant_user_root
    ubuntu1604.vm.provision "shell", inline: $install_python_2_7
  end
  config.vm.define "ubuntu1404" do |ubuntu1404|
    ubuntu1404.vm.box = "ubuntu/trusty64"
    ubuntu1404.vm.network "private_network", ip: "10.255.255.11"
    ubuntu1404.vm.provision "shell", inline: $make_vagrant_user_sudoer
  end
  config.vm.define "ubuntu1204" do |ubuntu1204|
    ubuntu1204.vm.box = "ubuntu/precise64"
    ubuntu1204.vm.network "private_network", ip: "10.255.255.12"
    ubuntu1204.vm.provision "shell", inline: $make_vagrant_user_root
  end
  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "centos/7"
    centos7.vm.network "private_network", ip: "10.255.255.20"
    centos7.vm.provision "shell", inline: $allow_ssh_password_auth_centos_7
    centos7.vm.provision "shell", inline: $make_vagrant_user_root
  end
  config.vm.define "centos6" do |centos6|
    centos6.vm.box = "centos/6"
    centos6.vm.network "private_network", ip: "10.255.255.21"
    centos6.vm.provision "shell", inline: $allow_ssh_password_auth_centos_6
    centos6.vm.provision "shell", inline: $make_vagrant_user_root
  end
#  config.vm.define "centos5" do |centos5|
#    centos5.vm.box = "hajee/centos-5.10-x86_64"
#    centos5.vm.network "private_network", ip: "10.255.255.22"
#  end

end
