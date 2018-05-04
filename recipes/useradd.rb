#
# Cookbook:: cis-rhel
# Recipe:: useradd
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

# xccdf_org.cisecurity.benchmarks_rule_5.4.1.4_Ensure_inactive_password_lock_is_30_days_or_less
cookbook_file '/etc/default/useradd' do
  source 'useradd'
  owner  'root'
  group  'root'
  mode   '0644'
  manage_symlink_source true
  action :create
end
