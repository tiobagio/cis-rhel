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

# 2.2.2_Ensure_X_Window_System_is_not_installed
yum_package 'xorg-x11*' do
  flush_cache :after
  action      :remove
end

# 2.2.4_Ensure_CUPS_is_not_enabled
service 'cups' do
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
