module Cms
  class ResourcesController < ApplicationController
    before_filter :set_resource

    def index
      @entries = @resource.all
    end

    private

      def set_resource
        @resource = params[:controller].classify.safe_constantize
      end
  end
end
