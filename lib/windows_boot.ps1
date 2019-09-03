#ps1_sysnative
$puppet_agent_msi_url = "https://downloads.puppetlabs.com/windows/puppet/puppet-agent-x64-latest.msi"
$puppet_agent_msi_path = Join-Path $ENV:TEMP puppet_agent.msi
$ErrorActionPreference = "Stop"
$wc = New-Object net.webclient
$wc.Downloadfile($puppet_agent_msi_url, $puppet_agent_msi_path)
cmd /c start /wait msiexec /qn /i $puppet_agent_msi_path /l*v puppet_agent_msi_log.txt PUPPET_MASTER_SERVER=manager.borg.trek
del $puppet_agent_msi_path
Set-DnsClientGlobalSetting -SuffixSearchList @("borg.trek")
Get-NetAdapter | Set-DnsClient -ConnectionSpecificSuffix "borg.trek"
Add-Content "$env:windir\System32\drivers\etc\hosts" "$(& "C:\Program Files\Puppet Labs\Puppet\bin\facter.bat" networking.ip) $(hostname).borg.trek $(hostname)"
Add-Content "$env:windir\System32\drivers\etc\hosts" "manager_ip_address manager.borg.trek"
& "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" config set server manager.borg.trek --section main
& "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" config set runinterval 300 --section main
& "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" resource service puppet ensure=running enable=true
