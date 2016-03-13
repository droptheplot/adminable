module Cms
  module Attribute
    module Association
      attr_reader :options_for_select, :association

      def options_for_select(entry)
        self.association.klass.all.reject{ |e| e == entry }.collect do |e|
          [e.try(:email) || e.try(:login) || e.try(:name) || e.try(:title) || e.id, e.id]
        end
      end
    end
  end
end
