#
# Cookbook:: cis-rhel
# Recipe:: kernel_modules
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

# xccdf_org.cisecurity.benchmarks_rule_1.1.1.1_Ensure_mounting_of_cramfs_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.2_Ensure_mounting_of_freevxfs_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.3_Ensure_mounting_of_jffs2_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.4_Ensure_mounting_of_hfs_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.5_Ensure_mounting_of_hfsplus_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.6_Ensure_mounting_of_squashfs_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.7_Ensure_mounting_of_udf_filesystems_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_1.1.1.8_Ensure_mounting_of_FAT_filesystems_is_disabled
if node['cis-rhel']['kernel']['disable_filesystems'].empty?
  file '/etc/modprobe.d/CIS-filesystems.conf' do
    action :delete
  end
else
  template '/etc/modprobe.d/CIS-filesystem.conf' do
    source 'filesystem_blacklisting.erb'
    mode '0440'
    owner 'root'
    group 'root'
    variables filesystems: node['os-hardening']['security']['kernel']['disable_filesystems']
  end

  node['os-hardening']['security']['kernel']['disable_filesystems'].each do |file_system|
    kernel_module file_system do
      modname file_system
      action  :unload
    end
  end
end

# xccdf_org.cisecurity.benchmarks_rule_3.5.1 Ensure DCCP is disabled
# xccdf_org.cisecurity.benchmarks_rule_3.5.2 Ensure SCTP is disabled
# xccdf_org.cisecurity.benchmarks_rule_3.5.4_Ensure_TIPC_is_disabled
# xccdf_org.cisecurity.benchmarks_rule_3.5.3_Ensure_RDS_is_disabled
if node['cis-rhel']['kernel']['disable_network_protocols'].empty?
  file '/etc/modprobe.d/CIS-network-protocols.conf' do
    action :delete
  end
else
  template '/etc/modprobe.d/CIS-network-protocols.conf' do
    source 'network_protocols_blacklisting.erb'
    mode '0440'
    owner 'root'
    group 'root'
    variables network_protocols: node['cis-rhel']['kernel']['disable_network_protocols']
  end

  node['cis-rhel']['kernel']['disable_network_protocols'].each do |file_system|
    kernel_module file_system do
      modname file_system
      action  :unload
    end
  end
end
