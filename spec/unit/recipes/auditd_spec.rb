#
# Cookbook:: cis-rhel
# Spec:: auditd
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

describe 'cis-rhel::auditd' do
  context 'When all attributes are default, on an RHEL 7' do
    platform 'redhat', '7'

    it 'renders the /etc/audit/rules.d/cis.rules file' do
      expect(chef_run).to render_file('/etc/audit/rules.d/cis.rules')
    end

    it 'template /etc/audit/rules.d/cis.rules notifies auditd service restart' do
      template = chef_run.template('/etc/audit/rules.d/cis.rules')
      expect(template).to notify('service[auditd]').to(:restart).immediately
    end

    it 'template /etc/audit/auditd.conf notifies auditd service reload' do
      template = chef_run.template('/etc/audit/auditd.conf')
      expect(template).to notify('service[auditd]').to(:reload).immediately
    end
  end
end

describe 'cis-rhel::auditd' do
  context 'When all attributes are default, on an RHEL 6' do
    platform 'redhat', '6'

    it 'renders the /etc/audit/rules.d/cis.rules file' do
      expect(chef_run).to render_file('/etc/audit/rules.d/cis.rules')
    end

    it 'template /etc/audit/rules.d/cis.rules notifies auditd service restart' do
      template = chef_run.template('/etc/audit/rules.d/cis.rules')
      expect(template).to notify('service[auditd]').to(:restart).immediately
    end

    it 'template /etc/audit/auditd.conf notifies auditd service reload' do
      template = chef_run.template('/etc/audit/auditd.conf')
      expect(template).to notify('service[auditd]').to(:reload).immediately
    end
  end
end
