#
# Cookbook:: cis-rhel
# Recipe:: auditd
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

# CIS-RHEL7 v2.2.0 - 4.1 - Configure System Accounting (auditd)

package 'audit' do
  action :install
end

service 'auditd' do
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] < '7'
    reload_command '/usr/libexec/initscripts/legacy-actions/auditd/reload'
    restart_command '/usr/libexec/initscripts/legacy-actions/auditd/restart'
  end
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] >= '7'
    reload_command '/usr/sbin/service auditd reload'
    restart_command '/usr/sbin/service auditd restart'
  end
  supports [:start, :stop, :restart, :reload, :status]
  action :enable
end

# Dynamically generate list of privileged programs and add to audit.rules
auditd_rules = Mixlib::ShellOut.new("find / -xdev \\( -perm -4000 -o -perm -2000 \\) -type f | awk '\{print \"-a always,exit -F path=\" $1 \" -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged\"\}'").run_command.stdout.split("\n")
template '/etc/audit/rules.d/cis.rules' do
  variables(
    'priveleged_programs': auditd_rules
  )
  source 'auditd.rules.erb'
  cookbook node['cis-rhel']['template_path']
  notifies :restart, 'service[auditd]', :immediately
end

template '/etc/audit/auditd.conf' do
  source 'auditd.conf.erb'
  cookbook node['cis-rhel']['template_path']
  notifies :reload, 'service[auditd]', :immediately
end
