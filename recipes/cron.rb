#
# Cookbook:: cis-rhel
# Recipe:: cron
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

include_recipe 'cron::default'

# Start fix for hardening of cronfiles
['/etc/cron.d', '/etc/cron.monthly', '/etc/cron.weekly',
 '/etc/cron.daily', '/etc/cron.hourly'].each do |crondir|
  directory crondir do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end
end

# xccdf_org.cisecurity.benchmarks_rule_5.1.2_Ensure_permissions_on_etccrontab_are_configured
['/etc/crontab', '/etc/anacrontab'].each do |cronfile|
  file cronfile do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end
end

# Begin xccdf_org.cisecurity.benchmarks_rule_6.1.11_Restrict_atcron_to_Authorized_Users
file '/etc/cron.deny' do
  action :delete
end

file '/etc/cron.allow' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# xccdf_org.cisecurity.benchmarks_rule_5.1.8_Ensure_atcron_is_restricted_to_authorized_user
file '/etc/at.allow' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end
