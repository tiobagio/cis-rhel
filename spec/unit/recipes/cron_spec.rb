#
# Cookbook:: cis-rhel
# Spec:: cron
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

describe 'cis-rhel::cron' do
  context 'When all attributes are default, on an CentOS 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'includes the cron::default recipe' do
      expect(chef_run).to include_recipe 'cron::default'
    end

    ['/etc/cron.d', '/etc/cron.monthly', '/etc/cron.weekly',
     '/etc/cron.daily', '/etc/cron.hourly'].each do |crondir|

      it "creates #{crondir} directory with attributes" do
        expect(chef_run).to create_directory(crondir).with(
          mode:  '0700',
          user:  'root',
          group: 'root'
        )
      end
    end

    ['/etc/crontab', '/etc/anacrontab'].each do |cronfile|
      it "creates #{cronfile} file with attributes" do
        expect(chef_run).to create_file(cronfile).with(
          mode:  '0700',
          user:  'root',
          group: 'root'
        )
      end
    end

    it 'deletes /etc/cron.deny file' do
      expect(chef_run).to delete_file('/etc/cron.deny')
    end

    it 'creates /etc/cron.allow file' do
      expect(chef_run).to create_file('/etc/cron.allow').with(
        mode:  '0700',
        user:  'root',
        group: 'root'
      )
    end
  end
end
