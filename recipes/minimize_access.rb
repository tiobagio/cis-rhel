#
# Cookbook:: cis-rhel
# Recipe:: permissions
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

include_recipe 'os-hardening::minimize_access'

# xccdf_org.cisecurity.benchmarks_rule_4.2.4_Ensure_permissions_on_all_logfiles_are_configured
execute '4-2-4-log-permissions' do
  command 'find /var/log -type f -exec chmod g-wx,o-rwx {} +'
  user    'root'
  only_if 'find /var/log -type f -ls'
  action  :run
end

%w(bashrc profile).each do |file|
  next unless node['platform_version'].to_i >= 7
  # xccdf_org.cisecurity.benchmarks_rule_5.4.5_Ensure_default_user_shell_timeout_is_900_seconds_or_less
  replace_or_add "ensure user shell timeout is set to #{node['cis-rhel']['shell']['tmout']}" do
    path    "/etc/#{file}"
    pattern 'TMOUT=*'
    line    "TMOUT=#{node['cis-rhel']['shell']['tmout']}"
    ignore_missing false
  end
end

# xccdf_org.cisecurity.benchmarks_rule_6.1.13_Audit_SUID_executables
include_recipe 'os-hardening::suid_sgid'
