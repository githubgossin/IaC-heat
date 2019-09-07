#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1
wget -O "$tempdeb" https://apt.puppetlabs.com/puppet6-release-bionic.deb
dpkg -i "$tempdeb"
apt-get update
apt-get -y install puppet-agent
echo "$(/opt/puppetlabs/bin/facter networking.ip) $(hostname).node.consul $(hostname)" >> /etc/hosts
echo "manager_ip_address manager.node.consul manager" >> /etc/hosts
/opt/puppetlabs/bin/puppet config set server manager.node.consul --section main
/opt/puppetlabs/bin/puppet config set runinterval 300 --section main
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
