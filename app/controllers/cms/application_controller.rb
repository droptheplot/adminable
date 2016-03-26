module Cms
  class ApplicationController < ActionController::Base
    def welcome
      redirect_to polymorphic_path(Cms::Configuration.resources.first.route)
    end
  end
end
