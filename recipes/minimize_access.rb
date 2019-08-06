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

# 5.4.3_Ensure_default_group_for_the_root_account_is_GID_0
execute 'set GID for the root account' do
  command 'usermod -g 0 root'
  user    'root'
  not_if { 'id -g' == 0 }
  action  :run
end

# 5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
replace_or_add "ensure default user umask is #{node['init']['umask']} in /etc/bashrc" do
  path    '/etc/bashrc'
  pattern '\s{7}umask*'
  line    "       umask #{node['init']['umask']}"
end

replace_or_add "ensure default user umask is #{node['init']['umask']} in /etc/profile" do
  path    '/etc/profile'
  pattern '\s{3}umask*'
  line    "   umask #{node['init']['umask']}"
end

if node['platform_version'].to_i >= 7
  # 5.4.5_Ensure_default_user_shell_timeout_is_900_seconds_or_less
  replace_or_add "ensure user shell timeout is set to #{node['shell']['tmout']} in /etc/bashrc" do
    path    '/etc/bashrc'
    pattern 'TMOUT=*'
    line    "TMOUT=#{node['shell']['tmout']}"
    ignore_missing false
  end

  replace_or_add "ensure user shell timeout is set to #{node['shell']['tmout']} in /etc/profile" do
    path    '/etc/profile'
    pattern 'TMOUT=*'
    line    "TMOUT=#{node['shell']['tmout']}"
    ignore_missing false
  end
end
