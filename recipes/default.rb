#
# Cookbook:: cis-rhel
# Recipe:: default
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

include_recipe 'cis-rhel::aide'
include_recipe 'cis-rhel::at'
include_recipe 'cis-rhel::auditd'
include_recipe 'cis-rhel::cron'
include_recipe 'cis-rhel::grub'
include_recipe 'cis-rhel::firewalld'
include_recipe 'cis-rhel::kernel_modules'
include_recipe 'cis-rhel::login_banners'
include_recipe 'cis-rhel::login_defs'
include_recipe 'cis-rhel::network_packet_remediation'
include_recipe 'cis-rhel::ntp'
include_recipe 'cis-rhel::pam'
include_recipe 'cis-rhel::partitions'
include_recipe 'cis-rhel::rsyslog'
include_recipe 'cis-rhel::packages_services'
include_recipe 'cis-rhel::ssh'
include_recipe 'cis-rhel::sysctl'
include_recipe 'cis-rhel::syslog-ng'
include_recipe 'cis-rhel::minimize_access'

cis_rhel_user_mgmt 'CIS benchmark'
