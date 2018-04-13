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

# https://www.cyberciti.biz/faq/linux-add-nodev-nosuid-noexec-options-to-temporary-storage-partitions/
# These do not persist yet

# centos7_1.1.1_Create_Separate_Partition_for_tmp:  Mount /tmp should be mounted
# centos7_1.1.2_Set_nodev_option_for_tmp_Partition: Mount /tmp should be mounted
# centos7_1.1.3_Set_nosuid_option_set_on_tmp_partition: Ensure nodev option set on /tmp partition
# centos7_1.1.4_Set_noexec_option_set_on_tmp_partition: Ensure nosuid option set on /tmp partition
mount '/tmp' do
  pass    0
  fstype  'tmpfs'
  device  'tmpfs'
  options 'nodev,nosuid,noexec'
  action  [:enable, :mount]
end

# TODO: These may be out of scope of the remediation. Remove if they are, add tests if they are not

# 1.1.8_Ensure_nodev_option_set_on_vartmp_partition: Ensure nodev option set on /var/tmp partition
# 1.1.9_Ensure_nosuid_option_set_on_vartmp_partition: Ensure nosuid option set on /var/tmp partition
# 1.1.10_Ensure_noexec_option_set_on_vartmp_partition: Ensure noexec option set on /var/tmp partition
# execute 'mount -o remount,nosuid,nodev,noexec /var/tmp' do
#   only_if 'findmnt /var/tmp'
#   not_if 'findmnt /var/tmp | grep nosuid,nodev,noexec'
# end

# 1.1.14_Ensure_nodev_option_set_on_home_partition: Ensure nodev option set on /home partition
# execute 'mount -o remount,nodev /home' do
#   only_if 'findmnt /home'
#   not_if 'findmnt /home | grep nodev'
# end

# 1.1.15_Ensure_nodev_option_set_on_devshm_partition: Ensure nodev option set on /dev/shm partition
# 1.1.16_Ensure_nosuid_option_set_on_devshm_partition: Ensure nosuid option set on /dev/shm partition
# 1.1.17_Ensure_noexec_option_set_on_devshm_partition: Ensure noexec option set on /dev/shm partition
# execute 'mount -o remount,nosuid,nodev,noexec /dev/shm' do
#   only_if 'findmnt /dev/shm'
#   not_if 'findmnt /dev/shm | grep nosuid,nodev,noexec'
# end
