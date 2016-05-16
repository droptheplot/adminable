module Adminable
  class FieldCollector
    # @return [ActiveRecord::Base] activerecord model class
    # @example
    #   Adminable::Fields::Collection.new(User).model
    #   # => User(id: integer, email: string, password_hash: string)
    attr_reader :model

    # @return [Array] fields from activerecord model
    attr_reader :all

    # @param model [ActiveRecord::Base] activerecord model class
    def initialize(model)
      @model = model
      @all ||= columns + associations
    end

    # Collects fields from model columns
    # @return [Array]
    def columns
      @columns ||= [].tap do |fields|
        @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
          fields << resolve(column.type, column.name)
        end
      end
    end

    # Collects fields from model associations
    # @return [Array]
    def associations
      @associations ||= [].tap do |fields|
        @model.reflect_on_all_associations.each do |association|
          fields << resolve(association.macro, association.name)
        end
      end
    end

    private

      def resolve(type, name)
        class_name = "adminable/fields/#{type}".classify
        "#{class_name}.new(:#{name})"
      end

      def required?(name)
        @model.validators_on(name).any? do |validator|
          validator.class == ActiveRecord::Validations::PresenceValidator
        end
      end
  end
end
