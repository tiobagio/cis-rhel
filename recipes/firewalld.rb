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

node.default['firewall']['redhat7_iptables'] = true

# TODO: Figure out a way to fix control 3.6.2
# 3.6.3_Ensure_loopback_traffic_is_configured
node.default['firewall']['allow_loopback'] = true

# If IPV6 is disabled in grub we cannot manage the IPV6 settings
# rubocop:disable Style/NumericPredicate
if ::File.exist?('/etc/default/grub')
  unless File.readlines('/etc/default/grub').grep(/ipv6.disable=1/).size.zero?
    node.default['firewall']['ipv6_enabled'] = false
  end
else
  node.default['firewall']['ipv6_enabled'] = false
end
# rubocop:enable Style/NumericPredicate
node.default['firewall']['ipv6_enabled'] = false
# 3.6.1_Ensure_iptables_is_installed
include_recipe 'firewall::default'

firewall_rule 'ssh' do
  port     22
  position 1
  command  :allow
end

# 3.6.3_Ensure_loopback_traffic_is_configured
firewall_rule 'allow loopback' do
  interface 'lo'
  protocol :none
  command :allow
  include_comment false
  only_if { node['firewall']['allow_loopback'] }
end

firewall_rule '-A OUTPUT -o lo -j ACCEPT' do
  protocol       :none
  direction      :out
  dest_interface 'lo'
  command        :allow
  include_comment false
  only_if { node['firewall']['allow_loopback'] }
end

firewall_rule '-A INPUT -s 127.0.0.0/8 -j DROP' do
  protocol  :none
  direction :in
  source    '127.0.0.0/8'
  command   :deny
  include_comment false
  only_if { node['firewall']['allow_loopback'] }
end

# 3.6.4_Ensure_outbound_and_established_connections_are_configured
firewall_rule node['firewall']['inbound']['connection']['tcp'] do
  direction :in
  protocol  :tcp
  stateful  node['firewall']['inbound']['connection']['stateful']['tcp'].collect(&:to_sym)
  command   :allow
  include_comment false
end

firewall_rule node['firewall']['inbound']['connection']['udp'] do
  direction :in
  protocol  :udp
  stateful  node['firewall']['inbound']['connection']['stateful']['udp'].collect(&:to_sym)
  command   :allow
  include_comment false
end

firewall_rule node['firewall']['inbound']['connection']['icmp'] do
  direction :in
  protocol  :icmp
  stateful  node['firewall']['inbound']['connection']['stateful']['icmp'].collect(&:to_sym)
  command   :allow
  include_comment false
end

firewall_rule node['firewall']['outbound']['connection']['tcp'] do
  direction :in
  protocol  :tcp
  stateful  node['firewall']['outbound']['connection']['stateful']['tcp'].collect(&:to_sym)
  command   :allow
  include_comment false
end

firewall_rule node['firewall']['outbound']['connection']['udp'] do
  direction :in
  protocol  :udp
  stateful  node['firewall']['outbound']['connection']['stateful']['udp'].collect(&:to_sym)
  command   :allow
  include_comment false
end

firewall_rule node['firewall']['outbound']['connection']['icmp'] do
  direction :in
  protocol  :icmp
  stateful  node['firewall']['outbound']['connection']['stateful']['icmp'].collect(&:to_sym)
  command   :allow
  include_comment false
end
