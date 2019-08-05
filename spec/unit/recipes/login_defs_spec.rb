#
# Cookbook:: cis-rhel
# Spec:: login_defs
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

describe 'cis-rhel::login_defs' do
  context 'When all attributes are default, on RHEL 7' do
    platform 'redhat', '7'

    it 'attribute pw_max_age should be 365' do
      pw_max_age_attribute = chef_run.node['auth']['pw_max_age']
      expect(pw_max_age_attribute).to eq 365
    end
  end
end

describe 'cis-rhel::login_defs' do
  context 'When all attributes are default, on an RHEL 6' do
    platform 'redhat', '6'

    it 'attribute pw_max_age should be 90' do
      pw_max_age_attribute = chef_run.node['auth']['pw_max_age']
      expect(pw_max_age_attribute).to eq 90
    end
  end
end
