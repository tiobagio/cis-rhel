#
# Cookbook:: cis-rhel
# Recipe:: grub
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

# 1.4.1_Ensure_permissions_on_bootloader_config_are_configured
if node['platform_version'].to_i >= 7
  package 'grub2' do
    action :install
  end

  # ensure correct permissions
  file '/boot/grub2/grub.cfg' do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end

  file '/boot/grub2/user.cfg' do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end

  # 1.4.2_Ensure_bootloader_password_is_set
  execute 'set bootloader password' do
    command "yes #{node['cis-rhel']['bootloader']['password']} | sudo script -q -c 'grub2-setpassword'"
    user    'root'
    only_if { !node['cis-rhel']['bootloader']['password'].nil? }
    not_if  "grep -E '^GRUB2_PASSWORD=.+$' /boot/grub2/user.cfg"
    action  :run
  end

  # 3.3.3_Ensure_IPv6_is_disabled
  # 4.1.3_Ensure_auditing_for_processes_that_start_prior_to_auditd_is_enabled
  replace_or_add 'insert line if it does not exist' do
    path    '/etc/default/grub'
    pattern 'GRUB_CMDLINE_LINUX="ipv6.disable=1 audit=1"'
    line    'GRUB_CMDLINE_LINUX="ipv6.disable=1 audit=1"'
    replace_only false
  end

  execute 'update grub' do
    command 'grub2-mkconfig -o /boot/grub2/grub.cfg'
    action :run
  end
elsif node['platform_version'].to_i == 6
  file '/boot/grub/grub.cfg' do
    mode   '0600'
    owner  'root'
    group  'root'
    action :create
  end
end
