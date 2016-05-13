module Adminable
  class AttributeCollector
    # @return [ActiveRecord::Base] activerecord model class
    # @example
    #   Adminable::Attributes::Collection.new(User).model
    #   # => User(id: integer, email: string, password_hash: string)
    attr_reader :model

    # @return [Array] attributes from activerecord model
    attr_reader :all

    # @param model [ActiveRecord::Base] activerecord model class
    def initialize(model)
      @model = model
      @all ||= columns + associations
    end

    # Collects attributes from model columns
    # @return [Array]
    #
    # rubocop:disable Metrics/MethodLength
    def columns
      @columns ||= [].tap do |attributes|
        @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
          attributes << resolve(column.type, column.name)
        end
      end
    end

    # Collects attributes from model associations
    # @return [Array]
    def associations
      @associations ||= [].tap do |attributes|
        @model.reflect_on_all_associations.each do |association|
          attributes << resolve(association.macro, association.name)
        end
      end
    end

    private

      def resolve(type, name)
        class_name = "adminable/attributes/types/#{type}".classify
        "#{class_name}.new(:#{name})"
      end

      def required?(name)
        @model.validators_on(name).any? do |validator|
          validator.class == ActiveRecord::Validations::PresenceValidator
        end
      end
  end
end
