require 'aws/record/attributes'
require 'active_support/core_ext/time/conversions'
require 'active_support/core_ext/time/zones'
require 'active_support/core_ext/date_time/conversions'
require 'active_support/core_ext/date_time/zones'

module AWS
  module Record
    module Attributes
      class DateTimeAttr 
        
        

        # Returns a DateTime object encoded as a string (suitable for sorting).
        #
        #   attribute.serialize(DateTime.parse('2001-01-01'))
        #   #=> '2001-01-01T00:00:00:Z)
        #
        # @param [DateTime] datetime The datetime object to serialize.
        # @param [Hash] options
        # @return [String] Returns the datetime object serialized to a string
        #   in ISO8601 format (e.g. '2011-01-02T10:11:12Z')
        def self.serialize datetime, options = {}
          unless datetime.is_a?(DateTime)
            msg = "expected a DateTime value, got #{datetime.class}"
            raise ArgumentError, msg  
          end

          original_zone = Time.zone
          Time.zone = 'UTC'
          string = datetime.in_time_zone.strftime('%Y-%m-%dT%H:%M:%S%z')
          Time.zone = original_zone
          string
        end

      end
    end
  end
end
