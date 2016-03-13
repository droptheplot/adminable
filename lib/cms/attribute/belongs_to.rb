module Cms
  module Attribute
    class BelongsTo < Base
      include Cms::Attribute::Association

      def key
        @association.foreign_key
      end
    end
  end
end
