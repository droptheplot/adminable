module Adminable
  module Attributes
    module Types
      class BelongsTo < Base
        def key
          "#{name}_id"
        end
      end
    end
  end
end
