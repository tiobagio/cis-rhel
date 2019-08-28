#
# Cookbook:: cis-rhel
# Recipe:: ssh
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

service 'sshd' do
  supports restart: true, status: true, reload: true
  action   [:enable, :start]
end

# 5.2.1_Ensure_permissions_on_etcsshsshd_config_are_configured
# 5.2.2_Ensure_SSH_Protocol_is_set_to_2
# 5.2.3_Ensure_SSH_LogLevel_is_set_to_INFO
# 5.2.4_Ensure_SSH_X11_forwarding_is_disabled
# 5.2.5_Ensure_SSH_MaxAuthTries_is_set_to_4_or_less
# 5.2.6_Ensure_SSH_IgnoreRhosts_is_enabled
# 5.2.7_Ensure_SSH_HostbasedAuthentication_is_disabled
# 5.2.8_Ensure_SSH_root_login_is_disabled
# 5.2.9_Ensure_SSH_PermitEmptyPasswords_is_disabled
# 5.2.10_Ensure_SSH_PermitUserEnvironment_is_disabled
# 5.2.11_Ensure_only_approved_MAC_algorithms_are_used
# 5.2.12_Ensure_SSH_Idle_Timeout_Interval_is_configured
# 5.2.13_Ensure_SSH_LoginGraceTime_is_set_to_one_minute_or_less
# 5.2.14_Ensure_SSH_access_is_limited
# 5.2.15_Ensure_SSH_warning_banner_is_configured
template '/etc/ssh/sshd_config' do
  source   'sshd_config.erb'
  mode     '0644'
  owner    'root'
  group    'root'
  notifies :restart, 'service[sshd]'
end
