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

# xccdf_org.cisecurity.benchmarks_rule_5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
# rubocop:disable Style/RescueModifier
%w(bashrc profile).each do |file|
  ruby_block 'ensure default user umask is 027' do
    block do
      fe = Chef::Util::FileEdit.new("/etc/#{file}")
      fe.search_file_replace_line(/(umask )\d{1,3}/, 'umask 027')
      fe.write_file
    end

    only_if { ::File.exist?("/etc/#{file}") }
    not_if  { find_resource!(:file, "/etc/#{file}") rescue false }
    not_if  { find_resource!(:template, "/etc/#{file}") rescue false }
    action :run
  end
end
# rubocop:enable Style/RescueModifier

# xccdf_org.cisecurity.benchmarks_rule_6.1.13_Audit_SUID_executables
include_recipe 'os-hardening::suid_sgid'
