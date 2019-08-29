#
# Cookbook:: cis-rhel
# Recipe:: login_banners
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

cis_gdm_cookbook = node['cis_gdm_template_path'] || 'cis-rhel'
cis_gdm_banner_message_cookbook = node['cis_filesystem_template_path'] || 'cis-rhel'

# 1.7.1 Command Line Warning Banners
#
# 1.7.1.1_Ensure_message_of_the_day_is_configured_properly: Ensure message of the day is configured properly (expected "" to match /(\v|\r|\m|\s|\S)/
# 1.7.1.4 Ensure permissions on /etc/motd are configured
# 1.7.1.2 Ensure local login warning banner is configured properly
# 1.7.1.5 Ensure permissions on /etc/issue are configured
# 1.7.1.3 Ensure remote login warning banner is configured properly
# 1.7.1.6 Ensure permissions on /etc/issue.net are configured
['/etc/motd', '/etc/issue', '/etc/issue.net'].each do |loginfile|
  file loginfile do
    content 'This system is managed by Chef.'
    mode    '0644'
    owner   'root'
    group   'root'
    action  :create
  end
end

# 1.7.2_Ensure_GDM_login_banner_is_configured
template '/etc/dconf/profile/gdm' do
  source 'gdm.erb'
  mode   '0644'
  owner  'root'
  group  'root'
  action :create
  only_if 'yum list installed | grep \'gdm\''
  notifies :run, 'execute[update grub]', :immediately
  cookbook cis_gdm_cookbook
end

template '/etc/dconf/db/gdm.d/01-banner-message' do
  source '01-banner-message.erb'
  mode   '0644'
  owner  'root'
  group  'root'
  action :create
  only_if 'yum list installed | grep \'gdm\''
  cookbook cis_gdm_banner_message_cookbook
end

execute 'update grub' do
  command 'dconf update'
  action :nothing
end
