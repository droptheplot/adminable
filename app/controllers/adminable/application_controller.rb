module Adminable
  class ApplicationController < ActionController::Base
    def welcome
      redirect_to polymorphic_path(
        Adminable::Configuration.resources.first.route
      )
    end
  end
end