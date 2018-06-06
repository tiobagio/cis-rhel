require 'spec_helper'

describe 'cis-rhel::packages_services' do
  context 'By default on CentOS 7' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
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
  end
end
