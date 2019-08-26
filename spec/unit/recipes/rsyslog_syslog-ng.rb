#
# Cookbook:: cis-rhel
# Spec:: rsyslog_syslog-ng
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

describe 'cis-rhel::rsyslog_syslog-ng' do
  context 'When all attributes are default, on redhat 7' do
    cached(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7')
      runner.converge(described_recipe)
    end

    it 'expect rsyslog to install and be configured' do
      if chef_run.node['rsyslog']['install']
        expect(chef_run).to install_package('rsyslog')
        expect(chef_run).to enable_service 'rsyslog'
        expect(chef_run).to create_file('/etc/rsyslog.conf').with(
            mode: '0640',
            owner: 'root',
            group: 'root'
          )
        expect(chef_run).to create_directory('/etc/rsyslog.d/').with(
            mode: '0640',
            owner: 'root',
            group: 'root'
          )
      end
    end

    it 'expect syslog-ng to install and be configured' do
      if chef_run.node['syslog-ng']['install']
        expect(chef_run).to install_package('syslog-ng')
        expect(chef_run).to enable_service 'syslog-ng'
        expect(chef_run).to create_file('/etc/syslog-ng/syslog-ng.conf').with(
            mode: '0640',
            owner: 'root',
            group: 'root'
          )
        expect(chef_run).to create_directory('/etc/syslog-ng/').with(
            mode: '0640',
            owner: 'root',
            group: 'root'
          )
      end
    end
  end
end
