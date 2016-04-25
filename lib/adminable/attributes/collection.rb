module Adminable
  module Attributes
    class Collection
      include Enumerable
      extend Forwardable

      def_delegators :@all, :[], :<<, :each, :first, :last, :push, :unshift

      attr_reader :model, :all

      # @param model [Class] model from Rails application e.g. `User` or `Post`
      def initialize(model)
        @model = model
        @all ||= columns + associations
      end

      def index
        all.select { |attribute| attribute.options[:index] }
      end

      def form
        all.select { |attribute| attribute.options[:form] }
      end

      def search
        all.select { |attribute| attribute.options[:search] }
      end

      # Collects attributes from model columns
      # @return [Array]
      #
      # rubocop:disable Metrics/MethodLength
      def columns
        @columns ||= [].tap do |attributes|
          @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
            begin
              attributes << resolve(column.type).new(
                column.name,
                required: required?(column.name)
              )
            rescue Adminable::AttributeNotImplemented
              next
            end
          end
        end
      end

      # Collects attributes from model associations
      # @return [Array]
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

      # Changes options for given attribute
      # @param name [Symbol] name of attribute e.g. `:title`
      # @param options [Hash] options to update
      def set(*args)
        options = args.extract_options!
        names = args

        options.each do |key, value|
          names.each do |name|
            get(name).options[key] = value
          end
        end
      end

      # Finds attribute by name
      # @param name [Symbol] name of attribute e.g. `:title`
      # @return [Object] e.g. `Adminable::Attribute::Types::String` for `:title`
      def get(name)
        @all.find { |attribute| attribute.name == name } ||
          raise(
            Adminable::AttributeNotFound,
            "couldn't find attribute with name `#{name}`"
          )
      end

      # Adds new attribute to collection
      # @param name [Symbol] name of attribute e.g. `:title`
      # @param type [Symbol] type of attribute e.g. `:string`
      def add(name, type, options = {})
        @all << resolve(type).new(name, **options)
      end

      private

        def resolve(type)
          "adminable/attributes/types/#{type}".classify.constantize
        rescue NameError
          raise(
            Adminable::AttributeNotImplemented,
            "type `#{type}` is not supported yet."
          )
        end

        def required?(name)
          @model.validators_on(name).any? do |validator|
            validator.class == ActiveRecord::Validations::PresenceValidator
          end
        end
    end
  end
end
