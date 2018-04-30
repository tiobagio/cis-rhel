#
# Cookbook:: augment
# Recipe:: vbox
#

# Changes for Virtualbox
# xccdf_org.cisecurity.benchmarks_rule_5.4.2_Ensure_system_accounts_are_non-login
user 'vboxadd' do
  shell '/sbin/nologin'
end
