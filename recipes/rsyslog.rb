#
# Cookbook:: cis-rhel
# Recipe:: rsyslog
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

# 5.1.4_Create_and_Set_Permissions_on_rsyslog_Log_File
include_recipe 'rsyslog::client'

%w(
  /usr/share/doc/rsyslog-doc
  /usr/share/doc/rsyslog-doc/html
).each do |dir|
  directory dir do
    mode    '0644'
    owner   'root'
    group   'root'
    action  :create
  end
end

# Set perms on Directory
directory '/etc/rsyslog.d/' do
  mode    '0640'
  owner   'root'
  group   'root'
  action  :create
end

file '/usr/share/doc/rsyslog-doc/html/rsyslog_conf.html' do
  content 'This system is managed by Chef.'
  mode    '0640'
  owner   'root'
  group   'root'
  action  :create_if_missing
end
