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
    command "yes #{node['bootloader']['password']} | sudo script -q -c 'grub2-setpassword'"
    user    'root'
    only_if { !node['bootloader']['password'].nil? }
    not_if  "grep -E '^GRUB2_PASSWORD=.+$' /boot/grub2/user.cfg"
    action  :run
  end

  grub_cmdline_linux_config = Mixlib::ShellOut.new('grep -E \'^GRUB_CMDLINE_LINUX=.+$\' /etc/default/grub | cut -d \'"\' -f2').run_command.stdout.split
  grub_cmdline_linux_default_config = Mixlib::ShellOut.new('grep -E \'^GRUB_CMDLINE_LINUX_DEFAULT=.+$\' /etc/default/grub | cut -d \'"\' -f2').run_command.stdout.split
  # 1.6.1.1_Ensure_SELinux_is_not_disabled_in_bootloader_configuration
  if node['grub']['selinux']
    grub_cmdline_linux_config.reject! { |setting| node['grub']['selinux'].include? setting }
    grub_cmdline_linux_default_config.reject! { |setting| node['grub']['selinux'].include? setting }
    if grub_cmdline_linux_default_config.empty?
      delete_lines 'remove GRUB_CMDLINE_LINUX_DEFAULT if the config is empty' do
        path '/etc/default/grub'
        pattern 'GRUB_CMDLINE_LINUX_DEFAULT=\"'
      end
    else
      replace_or_add 'insert GRUB_CMDLINE_LINUX_DEFAULT line if it does not exist, or update if it does exist' do
        path    '/etc/default/grub'
        pattern 'GRUB_CMDLINE_LINUX_DEFAULT=\"'
        line    "GRUB_CMDLINE_LINUX_DEFAULT=\"#{grub_cmdline_linux_default_config.join(' ')}\""
        replace_only false
      end
    end
  end

  # 3.3.3_Ensure_IPv6_is_disabled
  if node['grub']['audit']
    grub_cmdline_linux_config |= ["audit=#{node['grub']['audit']}"]
  end
  # 4.1.3_Ensure_auditing_for_processes_that_start_prior_to_auditd_is_enabled
  if node['grub']['ipv6.disable']
    grub_cmdline_linux_config |= ["ipv6.disable=#{node['grub']['ipv6.disable']}"]
  end

  replace_or_add 'insert GRUB_CMDLINE_LINUX line if it does not exist, or update if it does exist' do
    path    '/etc/default/grub'
    pattern 'GRUB_CMDLINE_LINUX=\"'
    line    "GRUB_CMDLINE_LINUX=\"#{grub_cmdline_linux_config.join(' ')}\""
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
