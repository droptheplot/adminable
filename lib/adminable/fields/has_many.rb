module Adminable
  module Fields
    class HasMany < Base
      def key
        "#{@name.to_s.singularize}_ids"
      end

      def strong_parameter
        { key => [] }
      end
    end
  end
end
