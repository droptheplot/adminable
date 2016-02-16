module Cms
  class ResourcesController < ApplicationController
    before_filter :set_resource
    before_filter :set_entry, only: [:edit, :update, :destroy]

    def index
      @entries = @resource.all
    end

    def new
      @entry = @resource.new
    end

    def edit
    end

    def create
      @entry = @resource.new(resource_params)

      if @entry.save
        redirect_to send("#{ @resource.model_name.route_key }_path")
      else
        render :new
      end
    end

    def update
      if @entry.update(resource_params)
        redirect_to send("#{ @resource.model_name.route_key }_path")
      else
        render :edit
      end
    end

    def destroy
      @entry.destroy

      redirect_to send("#{ @resource.model_name.route_key }_path")
    end

    private

      def set_resource
        @resource = params[:controller].classify.safe_constantize
      end

      def set_entry
        @entry = @resource.find(params[:id])
      end

      def resource_params
        params.require(@resource.model_name.element).permit(*@resource.columns.map(&:name))
      end
  end
end
