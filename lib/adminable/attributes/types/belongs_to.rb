module Adminable
  module Attributes
    module Types
      class BelongsTo < Base
        include Adminable::Attributes::Association

        def key
          @association.foreign_key
        end
      end
    end
  end
end
