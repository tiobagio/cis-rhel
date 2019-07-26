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

# xccdf_org.cisecurity.benchmarks_rule_5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
template '/etc/sysconfig/init' do
  source 'sysconfig_init.erb'
  action :create
  mode '0544'
  owner 'root'
  group 'root'
  variables umask: node['cis-rhel']['init']['daemon_umask']
  only_if { !node['cis-rhel']['init']['daemon_umask'].nil? }
end

# xccdf_org.cisecurity.benchmarks_rule_1.5.1_Ensure_core_dumps_are_restricted
# xccdf_org.cisecurity.benchmarks_rule_1.5.3_Ensure_address_space_layout_randomization_ASLR_is_enabled
# xccdf_org.cisecurity.benchmarks_rule_3.1.1_Ensure_IP_forwarding_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_3.1.2_Ensure_packet_redirect_sending_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_3.2.1_Ensure_source_routed_packets_are_not_accepted
# xccdf_org.cisecurity.benchmarks_rule_3.2.5_Ensure_broadcast_ICMP_requests_are_ignored
# xccdf_org.cisecurity.benchmarks_rule_3.2.6_Ensure_bogus_ICMP_responses_are_ignored
# xccdf_org.cisecurity.benchmarks_rule_3.2.7_Ensure_Reverse_Path_Filtering_is_enabled
# xccdf_org.cisecurity.benchmarks_rule_3.2.8_Ensure_TCP_SYN_Cookies_is_enabled
if node.attribute?('sysctl') && node['sysctl'].attribute?('params')
  coerce_attributes(node['sysctl']['params']).each do |x|
    k, v = x.split('=')
    sysctl k do
      value v
    end
  end
end

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
