module Adminable
  module Attributes
    class Association
      attr_reader :reflection, :model

      def initialize(reflection)
        @reflection = reflection
        @model = @reflection.klass.include(Adminable::ResourceConcern)
      end

      def options_for_select
        @model.all
      end
    end
  end
end
