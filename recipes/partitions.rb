#
# Cookbook:: cis-rhel
# Recipe:: partitions
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

# 1.1.2_Ensure_separate_partition_exists_for_tmp
# 1.1.3_Ensure_nodev_option_set_on_tmp_partition
# 1.1.4_Ensure_nosuid_option_set_on_tmp_partition
# 1.1.5_Ensure_noexec_option_set_on_tmp_partition
tmp_mount = Mixlib::ShellOut.new('mount | grep /tmp').run_command.stdout
mount '/tmp' do
  pass    0
  fstype  'tmpfs'
  device  'tmpfs'
  options 'nodev,nosuid,noexec,relatime'
  action  [:remount, :enable]
  not_if  { tmp_mount.match? /(?=.*noexec)(?=.*nosuid)(?=.*nodev)/ }
  only_if { !tmp_mount.empty? }
end

# 1.1.8_Ensure_nodev_option_set_on_vartmp_partition
# 1.1.9_Ensure_nosuid_option_set_on_vartmp_partition
# 1.1.10_Ensure_noexec_option_set_on_vartmp_partition
var_tmp_mount = Mixlib::ShellOut.new('mount | grep /var/tmp').run_command.stdout
mount '/var/tmp' do
  pass    0
  fstype  'tmpfs'
  device  'tmpfs'
  options 'rw,nosuid,nodev,noexec,relatime'
  action  [:remount, :enable]
  not_if  { var_tmp_mount.match? /(?=.*noexec)(?=.*nosuid)(?=.*nodev)/ }
  only_if { !var_tmp_mount.empty? }
end

# 1.1.14_Ensure_nodev_option_set_on_home_partition
home_mount = Mixlib::ShellOut.new('mount | grep /home').run_command.stdout
mount '/home' do
  pass    0
  fstype  'tmpfs'
  device  'tmpfs'
  options 'rw,nodev,relatime,data=ordered'
  action  [:remount, :enable]
  not_if  { home_mount.match? /(?=.*nodev)/ }
  only_if { !home_mount.empty? }
end

# 1.1.15_Ensure_nodev_option_set_on_devshm_partition
# 1.1.16_Ensure_nosuid_option_set_on_devshm_partition
# 1.1.17_Ensure_noexec_option_set_on_devshm_partition
shm_configured = Mixlib::ShellOut.new('mount | grep /dev/shm').run_command.stdout
mount '/dev/shm' do
  pass    0
  fstype  'tmpfs'
  device  'tmpfs'
  options 'rw,nodev,nosuid,noexec,relatime'
  action  [:remount, :enable]
  not_if  { shm_configured.match? /(?=.*noexec)(?=.*nosuid)(?=.*nodev)/ }
  only_if { !shm_configured.empty? }
end
