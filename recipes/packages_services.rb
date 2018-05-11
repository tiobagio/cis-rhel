#
# Cookbook:: cis-rhel
# Recipe:: packages_services
#

# xccdf_org.cisecurity.benchmarks_rule_2.2.4_Ensure_CUPS_is_not_enabled
service 'cups' do
  action [:disable, :stop]
end

# xccdf_org.cisecurity.benchmarks_rule_1.1.22_Disable_Automounting
service 'autofs' do
  action [:disable, :stop]
end

# xccdf_org.cisecurity.benchmarks_rule_1.5.4_Ensure_prelink_is_disabled
package 'prelink' do
  action :remove
end

# xccdf_org.cisecurity.benchmarks_rule_2.2.2_Ensure_X_Window_System_is_not_installed
yum_package 'xorg-x11*' do
  flush_cache :after
  action      :remove
end
