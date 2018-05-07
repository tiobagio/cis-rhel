# cis-rhel

This cookbook provides security-related recipes to apply CIS Benchmarks to RHEL based systems.

It prefers community cookbook driven solutions over trying to implement everything in this cookbook, using resources or attributes as necessary to customize and harden based on CIS benchmarks.

## Requirements

### Platforms

- RHEL/CentOS

### Chef

- Chef 13+

## Usage

Test out hardening a system by using the default recipe. In your environment, you most likely will customize to your environment. For example, the firewall configuration should be specific to the configuration you need in your environment.

## Development Testing

```
# Run Cookstyle linting and ChefSpec unit tests
rake

# Run Local Test-Kitchen
kitchen verify
```

### AWS Test-Kitchen (RHEL)

Ensure you have AWS credentials in `~/.aws/credentials`

Add the following variables:
Create a file named `.envrc` and add the following
```
# .envrc
export AWS_KEYPAIR_NAME='dca-kitchen'
export EC2_SSH_KEY_PATH='/path/to/id_rsa_kitchen.pem'
export KITCHEN_YAML=.kitchen.aws.yml
```

Run Test-Kitchen with AWS config
```
source .envrc
kitchen verify
```

## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)
