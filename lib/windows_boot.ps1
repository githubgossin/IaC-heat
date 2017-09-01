#ps1_sysnative
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses ("dir01_ip_address")
Set-DnsClientGlobalSetting -SuffixSearchList @("borg.trek")
Get-NetAdapter | Set-DnsClient -ConnectionSpecificSuffix "borg.trek"
$ErrorActionPreference = "Stop"
$puppet_agent_msi_url = "https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
$puppet_agent_msi_path = Join-Path $ENV:TEMP puppet_agent.msi
$wc = New-Object net.webclient
$wc.Downloadfile($puppet_agent_msi_url, $puppet_agent_msi_path)
cmd /c start /wait msiexec /qn /i $puppet_agent_msi_path /l*v puppet_agent_msi_log.txt PUPPET_MASTER_SERVER=manager.borg.trek
del $puppet_agent_msi_path
