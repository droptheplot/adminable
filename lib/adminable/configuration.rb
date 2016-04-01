module Adminable
  module Configuration
    def self.resources
      @resources ||= resources_paths.map do |resource_path|
        Adminable::Resource.new(
          resource_path.to_s.split('adminable/').last.sub(
            /_controller\.rb$/, ''
          )
        )
      end
    end

    def self.find_resource(name)
      resources.find { |resource| resource.name == name }
    end

    def self.resources_paths
      Dir[Rails.root.join('app/controllers/adminable/**/*_controller.rb')]
    end
  end
end