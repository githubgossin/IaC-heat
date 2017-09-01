#!/bin/bash -v
wget -O /tmp/KIdc33Mf.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i /tmp/KIdc33Mf.deb
apt-get update
apt-get -y install puppet-agent
echo "$(ip a | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | tr -d 'inet ' | grep -v '^127') $(hostname).borg.trek $(hostname)" >> /etc/hosts
echo "manager_ip_address manager.borg.trek manager" >> /etc/hosts
cat <<EOF >> /etc/puppetlabs/puppet/puppet.conf
[main]
    server = manager.borg.trek
EOF
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name "borg.trek";
supersede domain-name-servers dir01_ip_address;
EOF
reboot

