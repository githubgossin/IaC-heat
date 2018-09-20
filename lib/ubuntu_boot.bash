#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1
wget -O "$tempdeb" https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i "$tempdeb"
apt-get update
apt-get -y install puppet-agent
echo "$(ip a | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | tr -d 'inet ' | grep -v '^127') $(hostname).borg.trek $(hostname)" >> /etc/hosts
echo "manager_ip_address manager.borg.trek manager" >> /etc/hosts
cat <<EOF >> /etc/puppetlabs/puppet/puppet.conf
[main]
    server = manager.borg.trek
EOF
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
cat <<EOF >> /etc/netplan/50-cloud-init.yaml
            nameservers:
                search: [borg.trek]
                addresses: [dir01_ip_address]
        ens4:
            dhcp4: true
EOF
netplan apply
