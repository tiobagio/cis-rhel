#
# Cookbook:: cis-rhel
# Recipe:: kernel_modules
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

# 3.5.1 Ensure DCCP is disabled
cookbook_file '/etc/modprobe.d/dccp.conf' do
  source 'dccp.conf'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end

execute 'disable_dccp' do
  command '/sbin/modprobe -r dccp'
  only_if 'lsmod | grep dccp'
end

# 3.5.2 Ensure SCTP is disabled
cookbook_file '/etc/modprobe.d/sctp.conf' do
  source 'sctp.conf'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end

execute 'disable_sctp' do
  command '/sbin/modprobe -r sctp'
  only_if 'lsmod | grep sctp'
end

# xccdf_org.cisecurity.benchmarks_rule_3.5.4_Ensure_TIPC_is_disabled
cookbook_file '/etc/modprobe.d/tipc.conf' do
  source 'tipc.conf'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end

execute 'disable_tipc' do
  command '/sbin/modprobe -r tipc'
  only_if 'lsmod | grep tipc'
end

# xccdf_org.cisecurity.benchmarks_rule_3.5.3_Ensure_RDS_is_disabled
cookbook_file '/etc/modprobe.d/rds.conf' do
  source 'rds.conf'
  owner  'root'
  group  'root'
  mode   '0600'
  action :create
end

execute 'disable_rds' do
  command '/sbin/modprobe -r rds'
  only_if 'lsmod | grep rds'
end
