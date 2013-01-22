module AWS
  class SimpleDB
    class ItemCollection

      # We modify this method to raise the error about a missing value for placeholder.
      # That code it totatlly hosing everything relating to date queries.
      #
      # @private
      protected
      def replace_named_placeholders(str, named)
        named.each do |name, value|
          str = str.gsub(name.to_sym.inspect, coerce_substitution(value))
        end
        #str.scan(/:\S+/) do |missing|
        #  raise ArgumentError.new("missing value for placeholder #{missing}")
        #end
        str
      end

    end
  end
end
