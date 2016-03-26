module Cms
  module Attributes
    module Types
      class BelongsTo < Base
        include Cms::Attributes::Association

        def key
          @association.foreign_key
        end
      end
    end
  end
end
