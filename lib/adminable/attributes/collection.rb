module Adminable
  module Attributes
    class Collection
      attr_reader :model, :all

      def initialize(model)
        @model = model
        @all ||= columns + associations
      end

      def index
        columns.select(&:index?)
      end

      def form
        all.select(&:form?)
      end

      def search
        all.select(&:search?)
      end

      def columns
        @columns ||= [].tap do |attributes|
          @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
            attributes << resolve(column.type).new(
              column.name,
              required: required?(column.name)
            )
          end
        end
      end

      def associations
        @associations ||= [].tap do |attributes|
          @model.reflect_on_all_associations.each do |association|
            attributes << resolve(association.macro).new(
              association.name,
              required: required?(association.name),
              association: association
            )
          end
        end
      end

      def configure
        yield
      end

      def set(name, options = {})
        options.each do |key, value|
          get(name).send("#{key}=", value)
        end
      end

      def get(name)
        @all.find { |attribute| attribute.name == name }
      end

      def add(name, type, options = {})
        return if get(name)

        @all << resolve(type).new(name, **options)
      end

      private

        def resolve(type)
          "adminable/attributes/types/#{type}".classify.constantize
        rescue NameError
          Adminable::Attributes::Types::String
        end

        def required?(name)
          @model.validators_on(name).any? do |validator|
            validator.class == ActiveRecord::Validations::PresenceValidator
          end
        end
    end
  end
end
