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

# 5.1.2_Ensure_permissions_on_etccrontab_are_configured
['/etc/crontab', '/etc/anacrontab'].each do |cronfile|
  file cronfile do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end
end

# 5.1.3_Ensure_permissions_on_etccron.hourly_are_configured
directory '/etc/cron.hourly' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# 5.1.4_Ensure_permissions_on_etccron.daily_are_configured
directory '/etc/cron.daily' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# 5.1.5_Ensure_permissions_on_etccron.weekly_are_configured
directory '/etc/cron.weekly' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# 5.1.6_Ensure_permissions_on_etccron.monthly_are_configured
directory '/etc/cron.monthly' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# 5.1.7_Ensure_permissions_on_etccron.d_are_configured
directory '/etc/cron.d' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

# 5.1.8_Ensure_atcron_is_restricted_to_authorized_user
file '/etc/cron.deny' do
  action :delete
end

file '/etc/cron.allow' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end

file '/etc/at.allow' do
  mode   '0600'
  owner  'root'
  group  'root'
  action :create
end
