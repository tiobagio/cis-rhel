#
# Cookbook:: cis-rhel
# Spec:: network_packet_remediation
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

require 'spec_helper'

# TODO: Migrate to newer sysctl resources
# The sysctl cookbook this uses is older (because of os-hardening dependency)
# Chef 14 also includes a sysctl resource and the sysctl cookbook is being deprecated in favor of the resource
describe 'cis-rhel::network_packet_remediation' do
  context 'When all attributes are default, on an CentOS 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'includes sysctl::default recipe' do
      expect(chef_run).to include_recipe 'sysctl::default'
    end

    it 'installs tcp_wrappers package' do
      expect(chef_run).to install_package 'tcp_wrappers'
    end
  end
end
