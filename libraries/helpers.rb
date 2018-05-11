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
  end
end

::Chef::Recipe.send(:include, CISRHELCookbook::Helpers)
