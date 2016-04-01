module Adminable
  module Attributes
    class Collection
      attr_reader :model
      attr_writer :index, :form

      def initialize(model)
        @model = model
      end

      def index
        @index ||= all.except(:created_at, :updated_at)
      end

      def form
        @form ||= all.except(:id, :created_at, :updated_at)
      end

      def ransack
        @ransack ||= columns.except(:id, :created_at, :updated_at)
                            .select { |_, v| %w(string text).include?(v.type) }
      end

      def all
        [columns, association].inject(&:merge)
      end

      def columns
        @columns ||= {}.tap do |attribute|
          @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
            attribute[column.name] = resolve(
              column.type,
              column.name,
              required: required?(column.name)
            )
          end
        end.symbolize_keys
      end

      def association
        @association ||= {}.tap do |attribute|
          @model.reflect_on_all_associations.each do |association|
            attribute[association.name] = resolve(
              association.macro,
              association.name,
              required: required?(association.name),
              association: association
            )
          end
        end.symbolize_keys
      end

      private

        def resolve(type, *args)
          "adminable/attributes/types/#{type}".classify.constantize.new(*args)
        end

        def required?(name)
          @model.validators_on(name).any? do |validator|
            validator.class == ActiveRecord::Validations::PresenceValidator
          end
        end
    end
  end
end
