#
# Cookbook:: cis-rhel
# Spec:: aide
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

describe 'cis-rhel::aide' do
  context 'When all attributes are default, on RHEL 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.6')
      runner.converge(described_recipe)
    end

    it 'installs package' do
      expect(chef_run).to install_package('aide')
    end

    it 'creates cron' do
      expect(chef_run).to create_cron_d('aide')
    end
  end
end

describe 'cis-rhel::aide' do
  context 'When all attributes are default, on RHEL 6' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '6.10')
      runner.converge(described_recipe)
    end

    it 'installs package' do
      expect(chef_run).to install_package('aide')
    end

    it 'creates cron' do
      expect(chef_run).to create_cron_d('aide')
    end
  end
end
