module Cms
  module Attribute
    module Association
      attr_reader :options_for_select

      def options_for_select(entry)
        self.klass.all.reject{ |e| e == entry }.collect do |e|
          [e.try(:name) || e.try(:title) || e.id, e.id]
        end
      end
    end
  end
end
