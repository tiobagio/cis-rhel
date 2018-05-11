#
# Cookbook:: cis-rhel
# Recipe:: sysctl
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

# RHEL6 xccdf_org.cisecurity.benchmarks_rule_1.4.4_Ensure_interactive_boot_is_not_enabled
node.default['os-hardening']['security']['init']['prompt'] = false if rhel_6?
# RHEL6 xccdf_org.cisecurity.benchmarks_rule_1.4.3_Ensure_authentication_required_for_single_user_mode
node.default['os-hardening']['security']['init']['single'] = true if rhel_6?

include_recipe 'os-hardening::sysctl'

# xccdf_org.cisecurity.benchmarks_rule_2.2.7_Ensure_NFS_and_RPC_are_not_enabled
%w(
  nfs
  nfs-server
  rpcbind
).each do |svc|
  service svc do
    action [:disable, :stop]
  end
end

# Ensure rpcbind is inactive by removing it
# https://bugzilla.redhat.com/show_bug.cgi?id=1531984
package 'rpcbind' do
  action :remove
end
