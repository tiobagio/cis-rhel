#
# Cookbook:: cis-rhel
# Recipe:: selinux
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

# 1.6.2_Ensure_SELinux_is_installed
package 'libselinux'

# 1.6.1.2_Ensure_the_SELinux_state_is_enforcing
replace_or_add "insert SELINUX=#{node['selinux']['state']} line if it does not exist, or update if it does exist" do
  path    '/etc/selinux/config'
  pattern '^SELINUX='
  line    "SELINUX=#{node['selinux']['state']}"
  replace_only false
end

# 1.6.1.3_Ensure_SELinux_policy_is_configured
replace_or_add "insert SELINUXTYPE=#{node['selinux']['policy']} line if it does not exist, or update if it does exist" do
  path    '/etc/selinux/config'
  pattern '^SELINUXTYPE='
  line    "SELINUXTYPE=#{node['selinux']['policy']}"
  replace_only false
end
