#
# Cookbook:: cis-rhel
# Recipe:: login_defs
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

if rhel_6?
  # xccdf_org.cisecurity.benchmarks_rule_5.4.1.1_Ensure_password_expiration_is_90_days_or_less
  node.default['os-hardening']['auth']['pw_max_age'] = 90
elsif rhel_7?
  # xccdf_org.cisecurity.benchmarks_rule_5.4.1.1_Ensure_password_expiration_is_365_days_or_less
  node.default['os-hardening']['auth']['pw_max_age'] = 365
end
include_recipe 'os-hardening::login_defs'
