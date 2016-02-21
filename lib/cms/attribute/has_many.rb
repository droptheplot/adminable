module Cms
  module Attribute
    class HasMany < Base
      attr_reader :options_for_select

      def key
        "#{ @name.to_s.singularize }_ids"
      end

      def strong_parameter
        { self.key => [] }
      end

      def options_for_select(entry)
        self.klass.all.reject{ |e| e == entry }.collect do |e|
          [e.try(:name) || e.try(:title) || e.id, e.id]
        end
      end
    end
  end
end
