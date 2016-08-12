#!/bin/bash

#############
# Variables #
#############
KEYS=$(cat /tmp/authorized_keys)

SSHDIR=/root/.ssh

AK=${SSHDIR}/authorized_keys

#############
# Detect OS #
#############
arch=$(uname -m)
kernel=$(uname -r)
if [ -f /etc/lsb-release ]; then
        os=$(lsb_release -s -d | cut -f1 -d' ')
elif [ -f /etc/debian_version ]; then
        os="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ]; then
        os=$(cat /etc/redhat-release | cut -f1 -d' ')
else
        os="$(uname -s) $(uname -r)"
fi

###############################
# Create SSH dir and add keys #
###############################
mkdir -p $SSHDIR
chmod 700 $SSHDIR
echo -e $KEYS >> $AK
chmod 600 $AK

#########################################
# Modify SSH Daemon to accept root keys #
#########################################
sed -i 's/^#\{0,1\}PermitRootLogin \(yes\|no\)/PermitRootLogin without-password/g' /etc/ssh/sshd_config

###############
# Restart SSH #
###############
if [ $os == "Ubuntu" ];then
	service ssh restart
elif [ $os == "CentOS" ];then
	os_maj_ver7=$(cat /etc/redhat-release | cut -f4 -d ' ' | cut -f1 -d '.')
	os_maj_ver5=$(cat /etc/redhat-release | cut -f3 -d ' ' | cut -f1 -d '.')
	if [ $os_maj_ver7 == '7' ];then
		# Disable selinux
		echo "0"  > /selinux/enforce
		yum install libselinux-python -y
		systemctl restart sshd
	elif [ $os_maj_ver5 == '5' ];then
		# Disable selinux
		echo "0"  > /selinux/enforce
		yum install python-simplejson -y
		service sshd restart
	else
		# Disable selinux
		echo "0"  > /selinux/enforce
		yum install libselinux-python -y
		service sshd restart
	fi
fi
