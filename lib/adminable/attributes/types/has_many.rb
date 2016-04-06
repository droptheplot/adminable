module Adminable
  module Attributes
    module Types
      class HasMany < Base
        def key
          @key = "#{@name.to_s.singularize}_ids"
        end

        def strong_parameter
          { key => [] }
        end
      end
    end
  end
end
