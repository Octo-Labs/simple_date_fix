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

      # We modify this method to serialize DateTime attrs the same way that they
      # are stored.  This allows queries to actually work.
      # @private
      protected
      def coerce_substitution(subst)
        if subst.kind_of?(Array)
          "(" +
            subst.flatten.map { |s| coerce_substitution(s) }.join(", ") + ")"
        elsif subst.is_a?(DateTime)
          "'" + AWS::Record::Attributes::DateTimeAttr.serialize(subst) + "'"
        elsif subst.is_a?(Time)
          coerce_substitution(subst.to_datetime)
        else
          "'" + subst.to_s.gsub("'", "''") + "'"
        end
      end

    end
  end
end
