#
# Cookbook:: cis-rhel
# Recipe:: aide
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

# 1.3.2_Ensure_filesystem_integrity_is_regularly_checked
package 'aide' do
  action :install
end

# 1.3.2_Ensure_filesystem_integrity_is_regularly_checked
cron_d 'aide' do
  action :create
  minute '5'
  user 'root'
  command '/usr/sbin/aide --check'
  mailto node['cis-rhel']['cron_mailto'] if node['cis-rhel']['cron_mailto']
end
