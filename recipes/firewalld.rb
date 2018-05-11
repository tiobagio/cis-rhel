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

# TODO: Figure out why InSpec CIS RHEL 6 & 7 profiles fail even though the settings are correct
# xccdf_org.cisecurity.benchmarks_rule_3.6.3_Ensure_loopback_traffic_is_configured
node.default['firewall']['allow_loopback'] = true

include_recipe 'firewall::default'

firewall_rule 'ssh' do
  port     22
  position 1
  command  :allow
end

# xccdf_org.cisecurity.benchmarks_rule_3.6.3_Ensure_loopback_traffic_is_configured
firewall_rule '-A OUTPUT -o lo -j ACCEPT' do
  protocol       :none
  direction      :out
  dest_interface 'lo'
  command        :allow
  only_if        { linux? && node['firewall']['allow_loopback'] }
end

firewall_rule '-A INPUT -s 127.0.0.0/8 -j DROP' do
  protocol  :none
  direction :in
  source    '127.0.0.0/8'
  command   :deny
  only_if   { linux? && node['firewall']['allow_loopback'] }
end

# xccdf_org.cisecurity.benchmarks_rule_3.6.4_Ensure_outbound_and_established_connections_are_configured
%i(tcp udp icmp).each do |p|
  firewall_rule "-A INPUT -p #{p} -m state --state NEW,ESTABLISHED -j ACCEPT" do
    direction :in
    protocol  p
    stateful  [:related, :established]
    command   :allow
  end

  firewall_rule "-A OUTPUT -p #{p} -m state --state NEW,ESTABLISHED -j ACCEPT" do
    direction :out
    protocol  p
    stateful  [:related, :established]
    command   :allow
  end
end
