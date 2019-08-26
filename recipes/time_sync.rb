#
# Cookbook:: cis-rhel
# Recipe:: time_sync
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

chrony_cookbook = node['chrony_template_path'] || 'cis-rhel'
# 2.2.1.1_Ensure_time_synchronization_is_in_use
if node['ntp']['install'] == true && node['chrony']['install'] == false
  # 3.6_Configure_Network_Time_Protocol_NTP
  include_recipe 'ntp::default'

  cookbook_file '/etc/sysconfig/ntpd' do
    source 'etc_sysconfig_ntpd'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
    notifies :restart, "service[#{node['ntp']['service']}]"
  end

  # 2.2.1.2_Ensure_ntp_is_configured
  # Managing template file in this cookbook instead of recipe[ntp::default]
  edit_resource!(:template, node['ntp']['conffile']) do
    cookbook 'cis-rhel'
    source   'ntp.conf.erb'
  end
elsif node['chrony']['install'] == true || node['ntp']['install'] == false
  # 2.2.1.3_Ensure_chrony_is_configured
  package 'chrony' do
    action :install
  end

  service 'chrony-daemon' do
    service_name 'chronyd'
    supports     restart: true, status: true, reload: true
    action       [:enable, :start]
  end

  template '/etc/chrony.conf' do
    source 'chrony.conf.erb'
    mode   '0644'
    owner  'root'
    owner  'root'
    action :create
    notifies :restart, 'service[chrony-daemon]'
    cookbook chrony_cookbook
  end

  cookbook_file '/etc/sysconfig/chronyd' do
    source 'chronyd'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
    notifies :restart, 'service[chrony-daemon]'
  end

  cookbook_file '/usr/lib/systemd/system/chronyd.service' do
    source 'chronyd.service'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
    notifies :restart, 'service[chrony-daemon]'
  end
end
