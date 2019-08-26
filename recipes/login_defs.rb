#
# Cookbook:: cis-rhel
# Recipe:: login_defs
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

if rhel_6?
  # 5.4.1.1_Ensure_password_expiration_is_90_days_or_less
  node.default['auth']['pw_max_age'] = 90
elsif rhel_7?
  # 5.4.1.1_Ensure_password_expiration_is_365_days_or_less
  node.default['auth']['pw_max_age'] = 365
end
cis_login_defs_cookbook = node['cis_login_defs_template_path'] || 'cis-rhel'

template '/etc/login.defs' do
  source 'login.defs.erb'
  cookbook cis_login_defs_cookbook
  mode '0444'
  owner 'root'
  group 'root'
  variables(
      additional_user_paths: node['env']['extra_user_paths'].join(':'), # :/usr/local/games:/usr/games
      umask: node['env']['umask'],
      password_max_age: node['auth']['pw_max_age'],
      password_min_age: node['auth']['pw_min_age'],
      password_warn_age: node['auth']['pw_warn_age'],
      login_retries: node['auth']['retries'],
      login_timeout: node['auth']['timeout'],
      chfn_restrict: '', # "rwh"
      allow_login_without_home: node['auth']['allow_homeless'],
      uid_min: node['auth']['uid_min'],
      uid_max: node['auth']['uid_max'],
      gid_min: node['auth']['gid_min'],
      gid_max: node['auth']['gid_max'],
      sys_uid_min: node['auth']['sys_uid_min'],
      sys_uid_max: node['auth']['sys_uid_max'],
      sys_gid_min: node['auth']['sys_gid_min'],
      sys_gid_max: node['auth']['sys_gid_max'],
      mail_dir: node['auth']['maildir']
    )
end

users_with_passwords = Mixlib::ShellOut.new('egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1').run_command.stdout.split

users_with_passwords.each do |user|
  # convert user chage list to hash
  user_chage_info = Hash[*Mixlib::ShellOut.new("chage --list #{user}").run_command.stdout.delete("\t").strip.gsub(': ', ':').gsub("\n", ':').split(':')]
  # 5.4.1.1_Ensure_password_expiration_is_365_days_or_less
  execute 'set user pw_max_age' do
    command "chage --maxdays #{node['auth']['pw_max_age']} #{user}"
    user    'root'
    action  :run
    not_if { user_chage_info['Maximum number of days between password change'] == node['auth']['pw_max_age'] }
  end

  # 5.4.1.2_Ensure_minimum_days_between_password_changes_is_7_or_more
  execute 'set user pw_min_age' do
    command "chage --mindays #{node['auth']['pw_min_age']} #{user}"
    user    'root'
    action  :run
    not_if { user_chage_info['Minimum number of days between password change'] == node['auth']['pw_min_age'] }
  end

  # 5.4.1.3_Ensure_password_expiration_warning_days_is_7_or_more
  execute 'set user pw_warn_age' do
    command "chage --warndays #{node['auth']['pw_warn_age']} #{user}"
    user    'root'
    action  :run
    not_if { user_chage_info['Number of days of warning before password expires'] == node['auth']['pw_warn_age'] }
  end

  # calculate the current pw_inactive value by getting the difference between the expiry date and the inactive date
  pw_inactive = ((Date.parse user_chage_info['Password inactive']) - (Date.parse user_chage_info['Password expires'])).to_i
  # 5.4.1.4_Ensure_inactive_password_lock_is_30_days_or_less
  execute 'set user inactive password lock' do
    command "chage --inactive #{node['auth']['pw_inactive']} #{user}"
    user    'root'
    action  :run
    not_if { pw_inactive == node['auth']['pw_inactive'] }
  end

  # 5.4.1.5_Ensure_all_users_last_password_change_date_is_in_the_past
  today = Date.today.to_time.to_i / 86400
  password_last_changed = (Date.parse user_chage_info['Last password change']).to_time.to_i / 86400
  next unless password_last_changed > today
  execute 'lock user accounts with last password change date in the future' do
    command "passwd -l #{user}"
    user    'root'
    action  :run
    only_if node['auth']['lock_passwords']
  end
end

pw_inactive_default = Mixlib::ShellOut.new('useradd -D | grep "INACTIVE" | cut -d= -f2').run_command.stdout
# 5.4.1.4_Ensure_inactive_password_lock_is_30_days_or_less
execute 'set default password inactivity period' do
  command "useradd -D -f #{node['auth']['pw_inactive']}"
  user    'root'
  action  :run
  not_if  { pw_inactive_default == node['auth']['pw_inactive'] }
end

# 6.2.1_Ensure_password_fields_are_not_empty
Mixlib::ShellOut.new('cat /etc/shadow | awk -F: \'($2 == "" ) { print $1 }\'').run_command.stdout.split.each do |user|
  execute 'lock user accounts with empty password field' do
    command "passwd -l #{user}"
    user    'root'
    action  :run
    only_if node['account']['lock_passwordless_accounts']
  end
end
