#!/bin/bash
HOSTNAME="$(hostname)"
#echo "${HOSTNAME}"
echo "##########################"
ls /sys/class/net
echo "##########################"
echo "Which interface is your main network interface? Please type:"

read IF_SELECT

IPADDR="$(ifconfig ${IF_SELECT} |grep netmask|awk '{print $2}')"
echo "
127.0.0.1       localhost.localdomain localhost
${IPADDR}   davuthanyaman.com ${HOSTNAME} pvelocalhost

::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
" > /etc/hosts

echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
apt update -y
apt dist-upgrade -y
apt install proxmox-ve postfix open-iscsi -y


