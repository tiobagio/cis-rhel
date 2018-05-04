#
# Cookbook:: cis-rhel
# Recipe:: network_packet_remediation
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

# TODO: Migrate to newer sysctl resources
# The sysctl cookbook this uses is older (because of os-hardening dependency)
# Chef 14 also includes a sysctl resource and the sysctl cookbook is being deprecated in favor of the resource
include_recipe 'sysctl::default'

# Addresses Log Suspicious Packets
sysctl_param 'net.ipv4.conf.all.log_martians' do
  value 1
end
sysctl_param 'net.ipv4.conf.default.log_martians' do
  value 1
end

# Addresses Send Packet Redirects
sysctl_param 'net.ipv4.conf.all.send_redirects' do
  value 0
end
sysctl_param 'net.ipv4.conf.default.send_redirects' do
  value 0
end

# Addresses ICMP Redirect Acceptance
sysctl_param 'net.ipv4.conf.all.accept_redirects' do
  value 0
end
sysctl_param 'net.ipv4.conf.default.accept_redirects' do
  value 0
end
sysctl_param 'net.ipv4.conf.all.secure_redirects' do
  value 0
end
sysctl_param 'net.ipv4.conf.default.secure_redirects' do
  value 0
end

# xccdf_org.cisecurity.benchmarks_rule_3.3.3_Ensure_IPv6_is_disabled
cis_rhel_ipv6 'harden_ipv6' do
  action :harden
end

cis_rhel_ipv6 'disable_ipv6' do
  action :disable
end

# xccdf_org.cisecurity.benchmarks_rule_3.4.1_Ensure_TCP_Wrappers_is_installed
package 'tcp_wrappers' do
  action :install
end
