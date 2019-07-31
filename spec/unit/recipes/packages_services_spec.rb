require 'spec_helper'

describe 'cis-rhel::packages_services' do
  context 'When all attributes are default, on RHEL 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.6')
      runner.converge(described_recipe)
    end

    it 'disables and stops CUPS' do
      expect(chef_run).to disable_service 'cups'
      expect(chef_run).to stop_service 'cups'
    end

    it 'disables and stops autofs' do
      expect(chef_run).to disable_service 'autofs'
      expect(chef_run).to stop_service 'autofs'
    end

    it 'removes the prelink package' do
      expect(chef_run).to remove_package 'prelink'
    end

    it 'removes xorg-x11* packages' do
      expect(chef_run).to remove_yum_package 'xorg-x11*'
    end

    it 'disables and stops rhsnd service' do
      expect(chef_run).to disable_service 'rhnsd'
      expect(chef_run).to stop_service 'rhnsd'
    end

    it 'removes the setroubleshoot package' do
      expect(chef_run).to remove_package 'setroubleshoot'
    end

    it 'removes the mcstrans package' do
      expect(chef_run).to remove_package 'mcstrans'
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

    it 'removes the telnet package' do
      expect(chef_run).to remove_package 'telnet'
    end
  end
end
