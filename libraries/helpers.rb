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

    def rhel_7?
      if platform_family?('rhel') && node['platform_version'].to_i == 7
        return true
      end

      false
    end
  end

  module SysctlHelpers
    module Param
      def coerce_attributes(attr, out = nil)
        case attr
        when Array
          "#{out}=#{attr.join(' ')}"
        when String, Integer
          "#{out}=#{attr}"
        when Hash
          out += '.' unless out.nil?
          attr.map { |k, v| coerce_attributes(v, "#{out}#{k}") }.flatten.sort
        end
      end
    end
  end
end

::Chef::Recipe.send(:include, CISRHELCookbook::Helpers)
::Chef::Recipe.send(:include, CISRHELCookbook::SysctlHelpers::Param)
