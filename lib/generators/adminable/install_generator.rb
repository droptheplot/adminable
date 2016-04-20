require 'rails/generators/base'

module Adminable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../install/templates', __FILE__)

      def create_controller
        template(
          'application_controller.rb',
          'app/controllers/adminable/application_controller.rb'
        )
      end
    end
  end
end
