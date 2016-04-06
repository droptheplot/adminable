module Adminable
  module Attributes
    module Types
      class BelongsTo < Base
        def key
          @association.reflection.foreign_key
        end
      end
    end
  end
end
