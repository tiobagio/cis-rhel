#
# Cookbook:: cis-rhel
# Recipe:: ssh
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

# 6.2.2 Set LogLevel to INFO
node.default['ssh-hardening']['ssh']['server']['log_level'] = 'INFO'
# 6.2.12 12_Set_Idle_Timeout_Interval_for_User_Login
node.default['ssh-hardening']['ssh']['server']['client_alive_count'] = 0

include_recipe 'ssh-hardening::default'
