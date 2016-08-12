Creates a group of VirtualBox VMs with the following operating systems:

- Ubuntu 16.04 LTS
- Ubuntu 14.04 LTS
- Ubuntu 12.04 LTS
- CentOS 7
- CentOS 6

This is specifically intended for use with Ansible (and includes some Ansible boilerplate), but you can use it to test literally anything against the above versions of Ubuntu LTS and CentOS.

The Vagrantfile makes minimal configuration changes to support uniform SSH access to each VM and compatibility with Ansible. Specifically:
- "vagrant" user with root privileges
- Accept SSH password (ChallengeResponseAuthentication)
- Installs Python 2.7 where needed (Ubuntu 16.04)

(Very insecure! Don't expose to public networks and don't use for anything sensitive.)

## VMs
- ubuntu1604 at 10.255.255.10
- ubuntu1404 at 10.255.255.11
- ubuntu1204 at 10.255.255.12
- centos7 at 10.255.255.20
- centos6 at 10.255.255.21
- centos5 at 10.255.255.22

## Requirements
- Vagrant 1.8.4. Currently there is a [bug with Vagrant 1.8.5](https://github.com/mitchellh/vagrant/issues/7610) which prevents provisioning for the CentOS 7 VM. This will be fixed in Vagrant 1.8.6.

## How to Use
Clone the repo, `cd` to it, run `vagrant up`, and wait about 8 minutes.

### Ansible Usage Example
```
cd ansible
export ANSIBLE_CONFIG=ansible.cfg
$ ansible all -i hosts -m ping

centos7 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
ubuntu1604 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
ubuntu1404 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
ubuntu1204 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
centos6 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

If you don't disable host key checking, you may have to add each VM's host key to your known_hosts file by manually SSHing into each VM each time it is provisioned (e.g. `ssh vagrant@10.255.255.10`).

## Todo
- Disable host key checking in the boilerplate Ansible code - already done?
- Grant vagrant user root access on ubuntu1404, and/or resolve root vs sudoer across all VMs
- Add CentOS 5
