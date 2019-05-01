#
# Cookbook:: cis-rhel
# Spec:: grub
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

describe 'cis-rhel::grub' do
  context 'When all attributes are default, on CentOS 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'ensures grub2 package is installed' do
      expect(chef_run).to install_package 'grub2'
    end

    it 'sets correct file permissions for /boot/grub2/grub.cfg' do
      expect(chef_run).to create_file('/boot/grub2/grub.cfg').with(
        mode:  '0600',
        owner: 'root',
        group: 'root'
      )
    end
    it 'sets correct file permissions for /boot/grub2/user.cfg' do
      expect(chef_run).to create_file('/boot/grub2/user.cfg').with(
        mode:  '0600',
        owner: 'root',
        group: 'root'
      )
    end
  end
end
