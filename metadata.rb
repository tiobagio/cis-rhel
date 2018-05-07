name             'cis-rhel'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Proprietary - All Rights Reserved'
description      'Installs/Configures cis-rhel'
long_description 'Installs/Configures cis-rhel'
version          '0.2.0'
chef_version     '>= 13.1' if respond_to?(:chef_version)

source_url 'https://github.com/chef/cis-rhel'
issues_url 'https://github.com/chef/cis-rhel/issues'

supports 'redhat'
supports 'centos'

depends 'aide'
depends 'cron'
depends 'firewall'
depends 'ntp'
depends 'os-hardening'
depends 'rsyslog'
depends 'ssh-hardening'
depends 'sudo'
depends 'sysctl'
