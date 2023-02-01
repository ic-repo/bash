#!/bin/sh

# disable selinux
setenforce 0
sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config

# change swappiness runtime
sysctl -w vm.swappiness=0
# change swappiness in conf
sed -c -i "s/\(vm.swappiness *= *\).*/\10/" /etc/sysctl.conf
map="vm.swappiness"
grep "$map" /etc/sysctl.conf > /dev/null  || echo "$map = 0" >> /etc/sysctl.conf


yum update -y
yum install -y yum-utils \
    epel-release \
    nano wget\
    htop iftop iotop ioping

# ntp
yum -y install ntp ntpdate ntp-doc && chkconfig ntpd on && service ntpd start && ntpdate pool.ntp.org


exit 0
#reboot