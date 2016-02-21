module Cms
  module Attribute
    class HasMany < Base
      def key
        "#{ @name.to_s.singularize }_ids"
      end

      def strong_parameter
        { self.key => [] }
      end
    end
  end
end
