module Cms
  module Attributes
    module Types
      class HasMany < Base
        include Cms::Attributes::Association

        def key
          @key = "#{@name.to_s.singularize}_ids"
        end

        def strong_parameter
          { key => [] }
        end

        def show?
          @association.klass.any?
        end
      end
    end
  end
end
