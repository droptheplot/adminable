module Adminable
  module Attributes
    class Association
      attr_reader :reflection, :model, :all

      # @param reflection [Object] ActiveRecord::Reflection::HasManyReflection
      def initialize(reflection)
        @reflection = reflection
        @model = @reflection.klass
        @all = Adminable::Presenters::Entries.new(@model)
      end
    end
  end
end
