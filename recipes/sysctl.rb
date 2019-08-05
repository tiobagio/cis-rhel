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

# 1.5.1_Ensure_core_dumps_are_restricted
# 1.5.3_Ensure_address_space_layout_randomization_ASLR_is_enabled
# 3.1.1_Ensure_IP_forwarding_is_disabled
# 3.1.2_Ensure_packet_redirect_sending_is_disabled
# 3.2.1_Ensure_source_routed_packets_are_not_accepted
# 3.2.2_Ensure_ICMP_redirects_are_not_accepted
# 3.2.3_Ensure_secure_ICMP_redirects_are_not_accepted
# 3.2.5_Ensure_broadcast_ICMP_requests_are_ignored
# 3.2.6_Ensure_bogus_ICMP_responses_are_ignored
# 3.2.7_Ensure_Reverse_Path_Filtering_is_enabled
# 3.2.8_Ensure_TCP_SYN_Cookies_is_enabled
if node.attribute?('sysctl') && node['sysctl'].attribute?('params')
  coerce_attributes(node['sysctl']['params']).each do |x|
    k, v = x.split('=')
    sysctl k do
      value v
    end
  end
end

limits_cookbook = node['limits_template_path'] || 'cis-rhel'

# Partially remediates:
# 1.5.1_Ensure_core_dumps_are_restricted
template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  mode '0440'
  owner 'root'
  group 'root'
  action :delete if node['kernel']['enable_core_dump']
  cookbook limits_cookbook
end
