module Cms
  class PagesController < ResourcesController
    def resource_model
      Cms::Page
    end
  end
end
