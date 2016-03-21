require 'rails/generators/base'

module Cms
  module Generators
    class ResourceGenerator < Rails::Generators::Base
      source_root File.expand_path('../resource/templates', __FILE__)
      argument :resource_name, type: :string, default: 'post'

      def create_controller
        template('resource_controller.rb.erb', resource_file)
      end

      private

        def resource_file
          "app/controllers/cms/#{resource_name.underscore.pluralize}_controller.rb"
        end

        def resource_class
          resource_name.classify.demodulize.pluralize
        end

        def resource_modules
          resource_name.classify.deconstantize.split('::')
        end
    end
  end
end
