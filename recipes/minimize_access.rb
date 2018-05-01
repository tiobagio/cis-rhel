#
# Cookbook:: cis-rhel
# Recipe:: permissions
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

include_recipe 'os-hardening::minimize_access'

# xccdf_org.cisecurity.benchmarks_rule_4.2.4_Ensure_permissions_on_all_logfiles_are_configured
execute '4-2-4-log-permissions' do
  command 'find /var/log -type f -exec chmod g-wx,o-rwx {} +'
  user    'root'
  only_if 'find /var/log -type f -ls'
  action  :run
end
