module Adminable
  module Fields
    class BelongsTo < Base
      def key
        "#{name}_id"
      end
    end
  end
end
