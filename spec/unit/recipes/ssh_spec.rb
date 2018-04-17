#
# Cookbook:: cis-rhel
# Spec:: ssh
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

describe 'cis-rhel::ssh' do
  context 'When all attributes are default, on an CentOS 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    before(:all) do
      # ssh-hardening::server
      stub_command('getenforce | grep -vq Disabled && semodule -l | grep -q ssh_password').and_return('')
      # ssh-hardening::default
      stub_command("test $(awk '$5 < 2047 && $5 ~ /^[0-9]+$/ { print $5 }' /etc/ssh/moduli | uniq | wc -c) -eq 0").and_return(true)
    end

    it 'includes the ssh-hardening::default recipe' do
      expect(chef_run).to include_recipe 'ssh-hardening::default'
    end

    it 'has the correct log level set' do
      expect(chef_run.node['ssh-hardening']['ssh']['server']['log_level']).to eq('INFO')
    end

    it 'has the correct ClientAliveCount set' do
      expect(chef_run.node['ssh-hardening']['ssh']['server']['client_alive_count']).to eq(0)
    end
  end
end
