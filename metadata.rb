name             'cis-rhel'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Proprietary - All Rights Reserved'
description      'Installs/Configures cis-rhel'
long_description 'Installs/Configures cis-rhel'
version          '0.1.0'
chef_version '>= 12.19' if respond_to?(:chef_version)

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
