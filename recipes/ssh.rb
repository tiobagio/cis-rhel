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

node.default['ssh-hardening']['ssh']['server']['client_alive_count'] = 0
# 5.2.3_Ensure_SSH_LogLevel_is_set_to_INFO
node.default['ssh-hardening']['ssh']['server']['log_level'] = 'INFO'

# 5.2.12_Ensure_only_approved_MAC_algorithms_are_used
node.default['ssh-hardening']['ssh']['server']['weak_hmac'] = false
case node['platform_version'].to_i
when 6
  node.default['ssh-hardening']['ssh']['server']['mac'] = %w(
    hmac-sha2-512
    hmac-sha2-256
  ).join(',')
when 7
  node.default['ssh-hardening']['ssh']['server']['mac'] = %w(
    hmac-sha2-512-etm@openssh.com
    hmac-sha2-256-etm@openssh.com
    umac-128-etm@openssh.com
    hmac-sha2-512
    hmac-sha2-256
    umac-128@openssh.com
  ).join(',')
end

# 5.2.13_Ensure_SSH_LoginGraceTime_is_set_to_one_minute_or_less
node.default['ssh-hardening']['ssh']['server']['login_grace_time'] = 60
# 5.2.15_Ensure_SSH_warning_banner_is_configured
node.default['ssh-hardening']['ssh']['server']['banner'] = '/etc/issue.net'

include_recipe 'ssh-hardening::default'
