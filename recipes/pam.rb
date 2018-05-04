#
# Cookbook:: cis-rhel
# Recipe:: pam
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

# 6.3.2 Set Password Creation Requirement Parameters Using pam_pwquality
include_recipe 'os-hardening::pam'

cookbook_file '/etc/security/pwquality.conf' do
  source 'pwquality.conf'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end

cookbook_file '/etc/pam.d/password-auth' do
  source 'password-auth'
  owner  'root'
  group  'root'
  mode   '0644'
  manage_symlink_source true
  action :create
end

# xccdf_org.cisecurity.benchmarks_rule_5.6_Ensure_access_to_the_su_command_is_restricted
cookbook_file '/etc/pam.d/su' do
  source 'pam_d_su'
  owner  'root'
  group  'root'
  mode   '0644'
  manage_symlink_source true
  action :create
end

# xccdf_org.cisecurity.benchmarks_rule_5.3.2_Ensure_lockout_for_failed_password_attempts_is_configured
# Change cookbook source for template from os-hardening to cis-rhel
edit_resource!(:template, '/etc/pam.d/system-auth-ac') do
  cookbook 'cis-rhel'
end
