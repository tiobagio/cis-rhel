#
# Cookbook:: cis-rhel
# Recipe:: permissions
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

# 4.2.4_Ensure_permissions_on_all_logfiles_are_configured
execute '4-2-4-log-permissions' do
  command 'find /var/log -type f -exec chmod g-wx,o-rwx {} +'
  user    'root'
  only_if 'find /var/log -type f -ls'
  action  :run
end

# 5.4.2_Ensure_system_accounts_are_non-login
Mixlib::ShellOut.new('awk -F: \'($3 < 1000) {print $1 }\' /etc/passwd').run_command.stdout.split.each do |account|
  next unless account != 'root'
  user account do
    action :lock
  end
  next unless account != 'root' && account != 'sync' && account != 'shutdown' && account != 'halt'
  user account do
    shell '/usr/sbin/nologin'
  end
end

# 5.4.3_Ensure_default_group_for_the_root_account_is_GID_0
execute 'set GID for the root account' do
  command 'usermod -g 0 root'
  user    'root'
  not_if { 'id -g' == 0 }
  action  :run
end

# 5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
execute "ensure umask is #{node['init']['umask']} in /etc/bashrc" do
  command "sed -i \"s/umask\s[0-9]*/umask #{node['init']['umask']}/\" /etc/bashrc"
end

execute "set umask #{node['init']['umask']} in /etc/bashrc if not present" do
  command "echo 'umask #{node['init']['umask']}' >> /etc/bashrc"
  not_if  "grep ^\s*umask\s+#{node['init']['umask']}\s*(\s+#.*)?$ /etc/bashrc"
end

execute "ensure umask is #{node['init']['umask']} in /etc/profile" do
  command "sed -i \"s/umask\s[0-9]*/umask #{node['init']['umask']}/\" /etc/profile"
end

execute "set umask #{node['init']['umask']} in /etc/profile if not present" do
  command "echo 'umask #{node['init']['umask']}' >> /etc/profile"
  not_if  "grep ^\s*umask\s+#{node['init']['umask']}\s*(\s+#.*)?$ /etc/profile"
end

if node['platform_version'].to_i >= 7
  # 5.4.5_Ensure_default_user_shell_timeout_is_900_seconds_or_less
  execute "ensure TMOUT is #{node['shell']['tmout']} in /etc/bashrc" do
    command "sed -i \"s/TMOUT=[0-9]*/TMOUT=#{node['shell']['tmout']}/\" /etc/bashrc"
  end

  execute "set timeout #{node['shell']['tmout']} in /etc/bashrc if not present" do
    command "echo 'TMOUT=#{node['shell']['tmout']}' >> /etc/bashrc"
    not_if  "grep ^\s*TMOUT=#{node['shell']['tmout']}\s*(\s+#.*)?$ /etc/bashrc"
  end

  execute "ensure TMOUT is #{node['shell']['tmout']} in /etc/profile" do
    command "sed -i \"s/TMOUT=[0-9]*/TMOUT=#{node['shell']['tmout']}/\" /etc/profile"
  end

  execute "set timeout #{node['shell']['tmout']} in /etc/profile if not present" do
    command "echo 'TMOUT=#{node['shell']['tmout']}' >> /etc/profile"
    not_if  "grep ^\s*TMOUT=#{node['shell']['tmout']}\s*(\s+#.*)?$ /etc/profile"
  end
end

# 6.1.2_Ensure_permissions_on_etcpasswd_are_configured
# 6.1.3_Ensure_permissions_on_etcshadow_are_configured
# 6.1.4_Ensure_permissions_on_etcgroup_are_configured
# 6.1.5_Ensure_permissions_on_etcgshadow_are_configured
# 6.1.6_Ensure_permissions_on_etcpasswd-_are_configured
# 6.1.7_Ensure_permissions_on_etcshadow-_are_configured
# 6.1.8_Ensure_permissions_on_etcgroup-_are_configured
# 6.1.9_Ensure_permissions_on_etcgshadow-_are_configured
['/etc/passwd', '/etc/passwd-', '/etc/group', '/etc/group-'].each do |systemfile|
  file systemfile do
    mode '0644'
    owner 'root'
    group 'root'
  end
end
['/etc/gshadow', '/etc/gshadow-', '/etc/shadow', '/etc/shadow-'].each do |systemfile|
  file systemfile do
    mode '0000'
    owner 'root'
    group 'root'
  end
end

# 6.1.10_Ensure_no_world_writable_files_exist
unless node['filesystem']['non_world_writable_files'].empty?
  node['filesystem']['non_world_writable_files'].each do |filesystem|
    execute "ensure #{filesystem} is not world writable" do
      command "chmod -R o-w #{filesystem}"
      user    'root'
      action  :run
    end
  end
end
