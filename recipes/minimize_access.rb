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

%w(bashrc profile).each do |file|
  # 5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
  replace_or_add "ensure default user umask is #{node['init']['daemon_umask']}" do
    path    "/etc/#{file}"
    pattern '\s{7}umask*'
    line    "       umask #{node['init']['daemon_umask']}"
    ignore_missing false
  end

  next unless node['platform_version'].to_i >= 7
  # 5.4.5_Ensure_default_user_shell_timeout_is_900_seconds_or_less
  replace_or_add "ensure user shell timeout is set to #{node['cis-rhel']['shell']['tmout']}" do
    path    "/etc/#{file}"
    pattern 'TMOUT=*'
    line    "TMOUT=#{node['cis-rhel']['shell']['tmout']}"
    ignore_missing false
  end
end
