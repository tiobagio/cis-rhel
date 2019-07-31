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

password_system_auth = node['pam_system_auth_template_path'] || 'cis-rhel'
password_auth_cookbook = node['pam_password_auth_template_path'] || 'cis-rhel'

package 'pam_pwquality' do
  package_name 'libpwquality'
end

# 5.3.1_Ensure_password_creation_requirements_are_configured
cookbook_file '/etc/security/pwquality.conf' do
  source 'pwquality.conf'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end

# 5.3.1_Ensure_password_creation_requirements_are_configured
# 5.3.2_Ensure_lockout_for_failed_password_attempts_is_configured
# 5.3.3_Ensure_password_reuse_is_limited
# 5.3.4_Ensure_password_hashing_algorithm_is_SHA-512
template '/etc/pam.d/system-auth-ac' do
  source 'rhel_system_auth.erb'
  cookbook password_system_auth
  mode '0640'
  owner 'root'
  group 'root'
end

template '/etc/pam.d/password-auth' do
  source 'password-auth.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  manage_symlink_source true
  action :create
  cookbook password_auth_cookbook
end

# 5.6_Ensure_access_to_the_su_command_is_restricted
cookbook_file '/etc/pam.d/su' do
  source 'pam_d_su'
  owner  'root'
  group  'root'
  mode   '0644'
  manage_symlink_source true
  action :create
end
