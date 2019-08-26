#
# Cookbook:: cis-rhel
# Recipe:: rsyslog_syslog-ng
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

# 4.2.3_Ensure_rsyslog_or_syslog-ng_is_installed
# 4.2.1.1_Ensure_rsyslog_Service_is_enabled
if node['syslog-ng']['install'] == true && node['rsyslog']['install'] == false
  package 'syslog-ng' do
    action :install
  end

  service 'syslog-ng' do
    action [:enable, :start]
  end

  # 4.2.2.3_Ensure_syslog-ng_default_file_permissions_configured
  execute 'update perm option in syslog-ng.conf file' do
    command "sed -i 's/perm([0-9]\+)/perm(6040)/' /etc/syslog-ng/syslog-ng.conf"
  end

  # Set perms on Directory
  directory '/etc/syslog-ng/' do
    mode    '0640'
    owner   'root'
    group   'root'
    action  :create
  end

  # Set perms on conf files
  file '/etc/syslog-ng/syslog-ng.conf' do
    mode    '0640'
    owner   'root'
    group   'root'
  end

elsif node['rsyslog']['install'] == true || node['syslog-ng']['install'] == false
  package 'rsyslog' do
    action :install
  end

  service 'rsyslog' do
    action [:enable, :start]
  end

  # 4.2.1.3_Ensure_rsyslog_default_file_permissions_configured
  # 4.2.1.4_Ensure_rsyslog_is_configured_to_send_logs_to_a_remote_log_host
  # 4.2.1.5_Ensure_remote_rsyslog_messages_are_only_accepted_on_designated_log_hosts
  # TODO: Add notes in README about setting server
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

  replace_or_add 'insert $FileCreateMode line if it does not exist, or update if it does exist' do
    path    '/etc/rsyslog.conf'
    pattern '\$FileCreateMode'
    line    '$FileCreateMode 0640'
    replace_only false
  end

  # Set perms on conf files
  file '/etc/rsyslog.conf' do
    mode    '0640'
    owner   'root'
    group   'root'
  end

  Mixlib::ShellOut.new('find /etc/rsyslog.d/ -iname \*.conf').run_command.stdout.split.each do |path|
    file path do
      mode    '0640'
      owner   'root'
      group   'root'
    end

    replace_or_add 'insert $FileCreateMode line if it does not exist, or update if it does exist' do
      path    path
      pattern '\$FileCreateMode'
      line    '$FileCreateMode 0640'
      replace_only false
    end
  end

  file '/usr/share/doc/rsyslog-doc/html/rsyslog_conf.html' do
    content 'This system is managed by Chef.'
    mode    '0640'
    owner   'root'
    group   'root'
    action  :create_if_missing
  end
end
