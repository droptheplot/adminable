require 'rails/generators/base'

module Cms
  module Generators
    class ResourceGenerator < Rails::Generators::Base
      source_root File.expand_path('../resource/templates', __FILE__)
      argument :name, type: :string, default: 'post'

      def create_controller
        template('resource_controller.rb.erb', resource_file)
      end

      private

        def resource_file
          "app/controllers/cms/#{resource_name}_controller.rb"
        end

        def resource_name
          name.underscore.pluralize
        end

        def resource_class
          "cms/#{resource_name}".classify.pluralize
        end
    end
  end
end
