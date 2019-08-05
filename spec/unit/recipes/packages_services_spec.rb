require 'spec_helper'

describe 'cis-rhel::packages_services' do
  context 'When all attributes are default, on RHEL 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.6')
      runner.converge(described_recipe)
    end

    it 'disables and stops autofs' do
      expect(chef_run).to disable_service 'autofs'
      expect(chef_run).to stop_service 'autofs'
    end

    it 'disables and stops rhsnd service' do
      expect(chef_run).to disable_service 'rhnsd'
      expect(chef_run).to stop_service 'rhnsd'
    end

    it 'removes the prelink package' do
      expect(chef_run).to remove_package 'prelink'
    end

    it 'removes the setroubleshoot package' do
      expect(chef_run).to remove_package 'setroubleshoot'
    end

    it 'removes the mcstrans package' do
      expect(chef_run).to remove_package 'mcstrans'
    end

    it 'disables and stops chargen-dgram & chargen-stream' do
      expect(chef_run).to disable_service 'chargen-dgram'
      expect(chef_run).to stop_service 'chargen-dgram'
      expect(chef_run).to disable_service 'chargen-stream'
      expect(chef_run).to stop_service 'chargen-stream'
    end

    it 'disables and stops daytime-dgram & daytime-stream' do
      expect(chef_run).to disable_service 'daytime-dgram'
      expect(chef_run).to stop_service 'daytime-dgram'
      expect(chef_run).to disable_service 'daytime-stream'
      expect(chef_run).to stop_service 'daytime-stream'
    end

    it 'disables and stops discard-dgram & discard-stream' do
      expect(chef_run).to disable_service 'discard-dgram'
      expect(chef_run).to stop_service 'discard-dgram'
      expect(chef_run).to disable_service 'discard-stream'
      expect(chef_run).to stop_service 'discard-stream'
    end

    it 'disables and stops echo-dgram & echo-stream' do
      expect(chef_run).to disable_service 'echo-dgram'
      expect(chef_run).to stop_service 'echo-dgram'
      expect(chef_run).to disable_service 'echo-stream'
      expect(chef_run).to stop_service 'echo-stream'
    end

    it 'disables and stops time-dgram & time-stream' do
      expect(chef_run).to disable_service 'time-dgram'
      expect(chef_run).to stop_service 'time-dgram'
      expect(chef_run).to disable_service 'time-stream'
      expect(chef_run).to stop_service 'time-stream'
    end

    it 'disables and stops tftp' do
      expect(chef_run).to disable_service 'tftp'
      expect(chef_run).to stop_service 'tftp'
    end

    it 'disables and stops xinetd' do
      expect(chef_run).to disable_service 'xinetd'
      expect(chef_run).to stop_service 'xinetd'
    end

    it 'disables and stops avahi-daemon service' do
      expect(chef_run).to disable_service 'avahi-daemon'
      expect(chef_run).to stop_service 'avahi-daemon'
    end

    it 'disables and stops CUPS' do
      expect(chef_run).to disable_service 'cups'
      expect(chef_run).to stop_service 'cups'
    end

    it 'disables and stops dhcpd' do
      expect(chef_run).to disable_service 'dhcpd'
      expect(chef_run).to stop_service 'dhcpd'
    end

    it 'disables and stops ldap' do
      expect(chef_run).to disable_service 'ldap'
      expect(chef_run).to stop_service 'ldap'
    end

    it 'disables and stops nfs & nfs-server & rpcbind' do
      expect(chef_run).to disable_service 'nfs'
      expect(chef_run).to stop_service 'nfs'
      expect(chef_run).to disable_service 'nfs-server'
      expect(chef_run).to stop_service 'nfs-server'
      expect(chef_run).to disable_service 'rpcbind'
      expect(chef_run).to stop_service 'rpcbind'
    end

    it 'disables and stops named' do
      expect(chef_run).to disable_service 'named'
      expect(chef_run).to stop_service 'named'
    end

    it 'disables and stops vsftpd' do
      expect(chef_run).to disable_service 'vsftpd'
      expect(chef_run).to stop_service 'vsftpd'
    end

    it 'disables and stops httpd' do
      expect(chef_run).to disable_service 'httpd'
      expect(chef_run).to stop_service 'httpd'
    end

    it 'disables and stops dovecot' do
      expect(chef_run).to disable_service 'dovecot'
      expect(chef_run).to stop_service 'dovecot'
    end

    it 'disables and stops smb' do
      expect(chef_run).to disable_service 'smb'
      expect(chef_run).to stop_service 'smb'
    end

    it 'disables and stops squid' do
      expect(chef_run).to disable_service 'squid'
      expect(chef_run).to stop_service 'squid'
    end

    it 'disables and stops snmpd' do
      expect(chef_run).to disable_service 'snmpd'
      expect(chef_run).to stop_service 'snmpd'
    end

    it 'disables and stops ypserv' do
      expect(chef_run).to disable_service 'ypserv'
      expect(chef_run).to stop_service 'ypserv'
    end

    it 'disables and stops rsh.socket & rlogin.socket & rexec.socket' do
      expect(chef_run).to disable_service 'rsh.socket'
      expect(chef_run).to stop_service 'rsh.socket'
      expect(chef_run).to disable_service 'rlogin.socket'
      expect(chef_run).to stop_service 'rlogin.socket'
      expect(chef_run).to disable_service 'rexec.socket'
      expect(chef_run).to stop_service 'rexec.socket'
    end

    it 'disables and stops ntalk' do
      expect(chef_run).to disable_service 'ntalk'
      expect(chef_run).to stop_service 'ntalk'
    end

    it 'disables and stops telnet.socket' do
      expect(chef_run).to disable_service 'telnet.socket'
      expect(chef_run).to stop_service 'telnet.socket'
    end

    it 'disables and stops tftp.socket' do
      expect(chef_run).to disable_service 'tftp.socket'
      expect(chef_run).to stop_service 'tftp.socket'
    end

    it 'removes the ypbind package' do
      expect(chef_run).to remove_package 'ypbind'
    end

    it 'removes the rsh package' do
      expect(chef_run).to remove_package 'rsh'
    end

    it 'removes the talk package' do
      expect(chef_run).to remove_package 'talk'
    end

    it 'removes the telnet package' do
      expect(chef_run).to remove_package 'telnet'
    end

    it 'removes the openldap-clients package' do
      expect(chef_run).to remove_package 'openldap-clients'
    end
  end
end
