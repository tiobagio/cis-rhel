#
# Cookbook:: cis-rhel
# Spec:: default
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

describe 'cis-rhel::default' do
  context 'When all attributes are default, on an RHEL 7' do
    cached(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7')
      runner.converge(described_recipe)
    end

    before(:all) do
      # ssh-hardening::server
      stub_command('getenforce | grep -vq Disabled && semodule -l | grep -q ssh_password').and_return('')
      # ssh-hardening::default
      stub_command("test $(awk '$5 < 2047 && $5 ~ /^[0-9]+$/ { print $5 }' /etc/ssh/moduli | uniq | wc -c) -eq 0").and_return(true)
      # cis-rhel::kernel_modules
      stub_command('lsmod | grep dccp').and_return('')
      stub_command('lsmod | grep sctp').and_return('')
      stub_command('lsmod | grep tipc').and_return('')
      stub_command('lsmod | grep rds').and_return('')
      # cis-rhel::minimize_access
      stub_command('find /var/log -type f -ls').and_return('')
      stub_command("grep ^\s*umask\s+027\s*(\s+#.*)?$ /etc/bashrc").and_return('')
      stub_command("grep ^\s*umask\s+027\s*(\s+#.*)?$ /etc/profile").and_return('')
      stub_command("grep ^\s*TMOUT=600\s*(\s+#.*)?$ /etc/bashrc").and_return('')
      stub_command("grep ^\s*TMOUT=600\s*(\s+#.*)?$ /etc/profile").and_return('')
      # os-hardening::minimize_access
      stub_command("find /usr/local/sbin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      stub_command("find /usr/local/bin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      stub_command("find /usr/sbin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      stub_command("find /usr/bin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      stub_command("find /sbin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      stub_command("find /bin  -perm -go+w -type f | wc -l | egrep '^0$'").and_return(false)
      # cis-rhel:package_services
      stub_command('yum list installed | grep "xinetd"').and_return('')
      stub_command('grep ^gpgcheck /etc/yum.conf').and_return('')
      stub_command('grep ^gpgcheck=1 /etc/yum.conf').and_return('')
      stub_command('grep "inet_interfaces = loopback-only" /etc/postfix/main.cf').and_return('')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    %w(
      cis-rhel::aide
      cis-rhel::at
      cis-rhel::auditd
      cis-rhel::cron
      cis-rhel::grub
      cis-rhel::firewalld
      cis-rhel::kernel_modules
      cis-rhel::login_banners
      cis-rhel::login_defs
      cis-rhel::network_config
      cis-rhel::time_sync
      cis-rhel::pam
      cis-rhel::partitions
      cis-rhel::rsyslog
      cis-rhel::packages_services
      cis-rhel::ssh
      cis-rhel::sysctl
      cis-rhel::syslog-ng
      cis-rhel::minimize_access
    ).each do |recipe|
      it "includes #{recipe} recipe" do
        expect(chef_run).to include_recipe recipe
      end
    end
  end
end
