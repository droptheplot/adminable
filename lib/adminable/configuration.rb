module Adminable
  module Configuration
    def self.resources_paths
      Dir[Rails.root.join('app/controllers/adminable/**/*_controller.rb')]
        .reject { |f| f['app/controllers/adminable/application_controller.rb'] }
    end

    def self.redirect_root_path
      if Adminable.resources.any?
        Adminable.resources.first.name
      else
        Rails.application.routes.url_helpers.root_path
      end
    end
  end
end
