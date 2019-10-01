# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

name 'cis-rhel'

default_source :supermarket

run_list 'cis-rhel::default'

cookbook 'cis-rhel', path: '.'
