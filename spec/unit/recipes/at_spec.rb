#
# Cookbook:: cis-rhel
# Spec:: at
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

describe 'cis-rhel::at' do
  context 'When all attributes are default, on RHEL 7' do
    platform 'redhat', '7'

    it 'deletes /etc/at.deny file' do
      expect(chef_run).to delete_file('/etc/at.deny')
    end

    it 'creates /etc/at.allow file' do
      expect(chef_run).to create_file('/etc/at.allow').with(
        mode: '0700',
        user: 'root',
        group: 'root'
      )
    end
  end
end
