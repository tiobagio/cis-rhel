#
# Cookbook:: cis-rhel
# Library:: helpers
#

module CISRHELCookbook
  module Helpers
    def rhel_6?
      if platform_family?('rhel') && node['platform_version'].to_i == 6
        return true
      end

      false
    end

    def raw_iptable4(rule)
      rule.prepend('-4 ') unless rhel_6?
    end

    def raw_iptable6(rule)
      rule.prepend('-6 ') unless rhel_6?
    end
  end
end
