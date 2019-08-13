name             'cis-rhel'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Proprietary - All Rights Reserved'
description      'Installs/Configures cis-rhel'
long_description 'Installs/Configures cis-rhel'
version          '0.2.7'
chef_version     '>= 13.1' if respond_to?(:chef_version)

source_url 'https://github.com/chef/cis-rhel'
issues_url 'https://github.com/chef/cis-rhel/issues'

supports 'redhat', '>= 6.7'
supports 'centos', '>= 6.7'

depends 'firewall', '~> 2.7'
depends 'ntp', '~> 3.5'
depends 'rsyslog', '~> 6.0'
depends 'ssh-hardening', '~> 2.3'
depends 'line', '~> 2.0.2'
