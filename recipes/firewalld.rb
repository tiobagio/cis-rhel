#
# Cookbook:: cis-rhel
# Recipe:: firewalld
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

::Chef::Resource.send(:include, CISRHELCookbook::Helpers)

node.default['firewall']['redhat7_iptables'] = true

# xccdf_org.cisecurity.benchmarks_rule_3.6.3_Ensure_loopback_traffic_is_configured
node.default['firewall']['allow_loopback'] = true

include_recipe 'firewall::default'

firewall_rule 'ssh' do
  port     22
  position 1
  command  :allow
end

# xccdf_org.cisecurity.benchmarks_rule_3.6.3_Ensure_loopback_traffic_is_configured
[
  '-A INPUT -i lo -j ACCEPT',
  '-A OUTPUT -o lo -j ACCEPT',
  '-A INPUT -s 127.0.0.0/8 -j DROP',
].each do |rule|
  firewall_rule 'INPUT lo ACCEPT' do
    raw     raw_iptable4(rule)
    only_if { linux? && node['firewall']['allow_loopback'] }
  end
end

# xccdf_org.cisecurity.benchmarks_rule_3.6.4_Ensure_outbound_and_established_connections_are_configured
new_est_rules = [
  '-A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT',
  '-A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT',
  '-A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT',
  '-A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT',
  '-A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT',
  '-A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT',
]

new_est_ipv4_rules = Array.new(new_est_rules)
new_est_ipv4_rules.each do |ipv4_rule|
  firewall_rule 'IPv4 NEW and ESTABLISHED' do
    raw raw_iptable4(ipv4_rule)
  end
end

new_est_ipv6_rules = Array.new(new_est_rules)
new_est_ipv6_rules.each do |ipv6_rule|
  firewall_rule 'IPv6 NEW and ESTABLISHED' do
    raw raw_iptable6(ipv6_rule)
  end
end
