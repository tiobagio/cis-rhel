#
# Cookbook:: cis-rhel
# Recipe:: packages_services
#

# 1.1.22_Disable_Automounting
service 'autofs' do
  action [:disable, :stop]
end

# 1.2.5_Disable_the_rhnsd_Daemon
service 'rhnsd' do
  action [:disable, :stop]
end

# 1.5.4_Ensure_prelink_is_disabled
package 'prelink' do
  action :remove
end

# 1.6.1.4_Ensure_SETroubleshoot_is_not_installed
package 'setroubleshoot' do
  action :remove
end

# 1.6.1.5_Ensure_the_MCS_Translation_Service_mcstrans_is_not_installed
package 'mcstrans' do
  action :remove
end

# 2.1.1_Ensure_chargen_services_are_not_enabled
service 'chargen-dgram' do
  action [:disable, :stop]
end

service 'chargen-stream' do
  action [:disable, :stop]
end

# 2.1.2_Ensure_daytime_services_are_not_enabled
service 'daytime-dgram' do
  action [:disable, :stop]
end

service 'daytime-stream' do
  action [:disable, :stop]
end

# 2.1.3_Ensure_discard_services_are_not_enabled
service 'discard-dgram' do
  action [:disable, :stop]
end

service 'discard-stream' do
  action [:disable, :stop]
end

# 2.1.4_Ensure_echo_services_are_not_enabled
service 'echo-dgram' do
  action [:disable, :stop]
end

service 'echo-stream' do
  action [:disable, :stop]
end

# 2.1.5_Ensure_time_services_are_not_enabled
service 'time-dgram' do
  action [:disable, :stop]
end

service 'time-stream' do
  action [:disable, :stop]
end

# 2.1.6_Ensure_tftp_server_is_not_enabled
service 'tftp' do
  action [:disable, :stop]
end

# 2.1.7_Ensure_xinetd_is_not_enabled
service 'xinetd' do
  action [:disable, :stop]
end

# 2.2.2_Ensure_X_Window_System_is_not_installed
Mixlib::ShellOut.new('rpm -qa xorg-x11*').run_command.stdout.split.each do |xorg_package|
  package xorg_package do
    action :remove
  end
end

# 2.2.3_Ensure_Avahi_Server_is_not_enabled
service 'avahi-daemon' do
  action [:disable, :stop]
end

# 2.2.4_Ensure_CUPS_is_not_enabled
service 'cups' do
  action [:disable, :stop]
end

# 2.2.5_Ensure_DHCP_Server_is_not_enabled
service 'dhcpd' do
  action [:disable, :stop]
end

# 2.2.6_Ensure_LDAP_server_is_not_enabled
service 'ldap' do
  action [:disable, :stop]
end

# 2.2.7_Ensure_NFS_and_RPC_are_not_enabled
%w(
  nfs
  nfs-server
  rpcbind
).each do |svc|
  service svc do
    action [:disable, :stop]
  end
end

# 2.2.8_Ensure_DNS_Server_is_not_enabled
service 'named' do
  action [:disable, :stop]
end

# 2.2.9_Ensure_FTP_Server_is_not_enabled
service 'vsftpd' do
  action [:disable, :stop]
end

# 2.2.10_Ensure_HTTP_server_is_not_enabled
service 'httpd' do
  action [:disable, :stop]
end

# 2.2.11_Ensure_IMAP_and_POP3_server_is_not_enabled
service 'dovecot' do
  action [:disable, :stop]
end

# 2.2.12_Ensure_Samba_is_not_enabled
service 'smb' do
  action [:disable, :stop]
end

# 2.2.13_Ensure_HTTP_Proxy_Server_is_not_enabled
service 'squid' do
  action [:disable, :stop]
end

# 2.2.14_Ensure_SNMP_Server_is_not_enabled
service 'snmpd' do
  action [:disable, :stop]
end

# 2.2.16_Ensure_NIS_Server_is_not_enabled
service 'ypserv' do
  action [:disable, :stop]
end

# 2.2.17_Ensure_rsh_server_is_not_enabled
%w(
  rsh.socket
  rlogin.socket
  rexec.socket
).each do |svc|
  service svc do
    action [:disable, :stop]
  end
end

# 2.2.18_Ensure_talk_server_is_not_enabled
service 'ntalk' do
  action [:disable, :stop]
end

# 2.2.19_Ensure_telnet_server_is_not_enabled
service 'telnet.socket' do
  action [:disable, :stop]
end

# 2.2.20_Ensure_tftp_server_is_not_enabled
service 'tftp.socket' do
  action [:disable, :stop]
end

# 2.2.21_Ensure_rsync_service_is_not_enabled
service 'rsyncd' do
  action [:disable, :stop]
end

# 2.3.1_Ensure_NIS_Client_is_not_installed
package 'ypbind' do
  action :remove
end

# 2.3.2_Ensure_rsh_client_is_not_installed
package 'rsh' do
  action :remove
end

# 2.3.3_Ensure_talk_client_is_not_installed
package 'talk' do
  action :remove
end

# 2.3.4_Ensure_telnet_client_is_not_installed
package 'telnet' do
  action :remove
end

# 2.3.5_Ensure_LDAP_client_is_not_installed
package 'openldap-clients' do
  action :remove
end
