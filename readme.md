Creates a group of VirtualBox VMs as follows:

| OS               | VM Name    | Private IP Address |
|------------------|------------|--------------------|
| Ubuntu 16.04 LTS | ubuntu1604 | 10.255.255.10      |
| Ubuntu 14.04 LTS | ubuntu1404 | 10.255.255.11      |
| Ubuntu 12.04 LTS | ubuntu1204 | 10.255.255.12      |
| CentOS 7         | centos7    | 10.255.255.20      |
| CentOS 6         | centos6    | 10.255.255.21      |

This is intended for use with Ansible (and includes some Ansible boilerplate), but you can use it to test literally anything against the above operating systems.

The Vagrantfile makes minimal configuration changes to support uniform SSH access to each VM and compatibility with Ansible. Specifically:
- "vagrant" user with root privileges and password "vagrant"
- Accept SSH password auth (ChallengeResponseAuthentication)
- Installs Python 2.7 where needed

(Very insecure! Don't expose to public networks and don't use for anything sensitive.)

## Requirements
- Vagrant. Currently there is a [bug with Vagrant 1.8.5](https://github.com/mitchellh/vagrant/issues/7610) which breaks provisioning for the CentOS 7 VM. This will be fixed in Vagrant 1.8.6; in the meantime use 1.8.4.
- VirtualBox

## How to Use
Clone the repo, `cd` to it, run `vagrant up`, and wait about 8 minutes for the provisioning script to complete. You may see "stdin: is not a tty" errors during Ubuntu provisioning; this is [safe to ignore](http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html).

You can connect to a VM via vagrant ssh (`vagrant ssh centos7`), or regular SSH to its private IP address (`ssh vagrant@10.255.255.20`).


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

### SSH Host Key Checking
After destroying and re-provisioning the pool, the VMs will have different host keys than the ones you previously accepted into your known_hosts file; this breaks SSH and Ansible. Run clean_known_hosts.sh to fix this quickly.

## Todo
- Disable host key checking in the boilerplate Ansible code - already done?
- Grant vagrant user root access on ubuntu1404, and/or resolve root vs sudoer across all VMs
- Add CentOS 5
- http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
