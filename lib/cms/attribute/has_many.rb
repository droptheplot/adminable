module Cms
  module Attribute
    class HasMany < Base
      include Cms::Attribute::Association

      def key
        "#{ @name.to_s.singularize }_ids"
      end

      def strong_parameter
        { self.key => [] }
      end
    end
  end
end
