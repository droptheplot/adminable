require 'rails/generators/base'

module Adminable
  module Generators
    class ResourceGenerator < Rails::Generators::Base
      source_root File.expand_path('../resource/templates', __FILE__)
      argument :name, type: :string, default: 'post'

      def create_controller
        template('resource_controller.rb.erb', resource_file)
      end

      private

        def resource_file
          "app/controllers/adminable/#{resource_name}_controller.rb"
        end

        def resource_name
          name.underscore.pluralize
        end

        def resource_class_name
          "adminable/#{resource_name}".classify.pluralize
        end

        def model_class
          name.classify.constantize
        end

        def attributes
          Adminable::AttributeCollector.new(model_class).all
        end
    end
  end
end
