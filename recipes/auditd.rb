#
# Cookbook:: cis-rhel
# Recipe:: auditd
#
# Copyright:: 2018, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package 'audit' do
  action :install
end

# 4.1.2_Ensure_auditd_service_is_enabled
service 'auditd' do
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] < '7'
    reload_command '/usr/libexec/initscripts/legacy-actions/auditd/reload'
    restart_command '/usr/libexec/initscripts/legacy-actions/auditd/restart'
  end
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] >= '7'
    reload_command '/usr/sbin/service auditd reload'
    restart_command '/usr/sbin/service auditd restart'
  end
  supports [:start, :stop, :restart, :reload, :status]
  action :enable
end

auditd_rules_cookbook = node['auditd_rules_template_path'] || 'cis-rhel'
auditd_cookbook = node['auditd_template_path'] || 'cis-rhel'

# Dynamically generate list of privileged programs and add to audit.rules
auditd_rules = Mixlib::ShellOut.new("find / -xdev \\( -perm -4000 -o -perm -2000 \\) -type f | awk '\{print \"-a always,exit -F path=\" $1 \" -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged\"\}'").run_command.stdout.split("\n")
# 4.1.4_Ensure_events_that_modify_date_and_time_information_are_collected
# 4.1.5_Ensure_events_that_modify_usergroup_information_are_collected
# 4.1.6_Ensure_events_that_modify_the_systems_network_environment_are_collected
# 4.1.7_Ensure_events_that_modify_the_systems_Mandatory_Access_Controls_are_collected
# 4.1.8_Ensure_login_and_logout_events_are_collected
# 4.1.9_Ensure_session_initiation_information_is_collected
# 4.1.10_Ensure_discretionary_access_control_permission_modification_events_are_collected
# 4.1.11_Ensure_unsuccessful_unauthorized_file_access_attempts_are_collected
# 4.1.12_Ensure_use_of_privileged_commands_is_collected
# 4.1.13_Ensure_successful_file_system_mounts_are_collected
# 4.1.14_Ensure_file_deletion_events_by_users_are_collected
# 4.1.15_Ensure_changes_to_system_administration_scope_sudoers_is_collected
# 4.1.16_Ensure_system_administrator_actions_sudolog_are_collected
# 4.1.17_Ensure_kernel_module_loading_and_unloading_is_collected
# 4.1.18_Ensure_the_audit_configuration_is_immutable
template '/etc/audit/rules.d/cis.rules' do
  variables(
    'privileged_programs': auditd_rules
  )
  source 'auditd.rules.erb'
  cookbook auditd_rules_cookbook
  notifies :restart, 'service[auditd]', :immediately
end

# 4.1.1.2_Ensure_system_is_disabled_when_audit_logs_are_full
# 4.1.1.3_Ensure_audit_logs_are_not_automatically_deleted
template '/etc/audit/auditd.conf' do
  source 'auditd.conf.erb'
  cookbook auditd_cookbook
  notifies :reload, 'service[auditd]', :immediately
end
