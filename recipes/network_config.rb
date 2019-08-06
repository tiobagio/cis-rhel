#
# Cookbook:: cis-rhel
# Recipe:: network_config
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

# 3.4.1_Ensure_TCP_Wrappers_is_installed
package 'tcp_wrappers' do
  action :install
end

# 3.4.4_Ensure_permissions_on_etchosts.allow_are_configured
execute 'set ownership on /etc/hosts.allow' do
  command 'chown root:root /etc/hosts.allow'
end

execute 'set permissions on /etc/hosts.allow' do
  command 'chmod 644 /etc/hosts.allow'
end

# 3.4.5_Ensure_permissions_on_etchosts.deny_are_configured
execute 'set ownership on /etc/hosts.deny' do
  command 'chown root:root /etc/hosts.deny'
end

execute 'set permissions on /etc/hosts.deny' do
  command 'chmod 644 /etc/hosts.deny'
end
