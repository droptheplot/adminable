module Cms
  module Configuration
    def self.resources_names
      Cms::ResourcesController.descendants.map{ |d| d.controller_name }
    end
  end
end
