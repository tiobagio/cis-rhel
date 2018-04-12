#
# Cookbook:: cis-rhel
# Recipe:: ntp
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
#

# xccdf_org.cisecurity.benchmarks_rule_3.6_Configure_Network_Time_Protocol_NTP
include_recipe 'ntp::default'

cookbook_file '/etc/sysconfig/ntpd' do
  source 'etc_sysconfig_ntpd'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
  notifies :restart, "service[#{node['ntp']['service']}]"
end
