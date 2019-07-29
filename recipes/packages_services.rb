#
# Cookbook:: cis-rhel
# Recipe:: packages_services
#

# 2.2.4_Ensure_CUPS_is_not_enabled
service 'cups' do
  action [:disable, :stop]
end

# 1.1.22_Disable_Automounting
service 'autofs' do
  action [:disable, :stop]
end

# 1.5.4_Ensure_prelink_is_disabled
package 'prelink' do
  action :remove
end

# 2.2.2_Ensure_X_Window_System_is_not_installed
yum_package 'xorg-x11*' do
  flush_cache :after
  action      :remove
end

# 1.2.5_Disable_the_rhnsd_Daemon
service 'rhnsd' do
  action [:disable, :stop]
end
