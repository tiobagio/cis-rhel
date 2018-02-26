# cis_rhel

This cookbook provides security-related recipes to apply CIS Benchmarks to RHEL based systems.

It does not:

* Install or update system packages.
* Install security patches.

It prefers community cookbook driven solutions over trying to implement everything in this cookbook, using resources or attributes as necessary to customize and harden based on CIS benchmarks.

## Requirements

### Platforms

- RHEL/CentOS

### Chef

- Chef 12.19+

### Cookbooks

* 'aide'
* 'os-hardening'
* 'sudo'
* 'firewall'
* 'ssh-hardening'
* 'cron'
* 'sysctl'
* 'rsyslog'

## Usage

Test out hardening a system by using the default recipe. In your environment, you most likely will customize to your environment. For example, the firewall configuration should be specific to the configuration you need in your environment.


## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)
