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
  context 'When all attributes are default, on an RHEL 7' do
    cached(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7')
      runner.converge(described_recipe)
    end

    it 'renders the /etc/ssh/sshd_config file' do
      expect(chef_run).to render_file('/etc/ssh/sshd_config')
    end

    it 'template /etc/ssh/sshd_config notifies sshd service restart' do
      template = chef_run.template('/etc/ssh/sshd_config')
      expect(template).to notify('service[sshd]').to(:restart)
    end
  end
end
