module Cms
  class ResourcesController < ApplicationController
    before_filter :set_resource
    before_filter :set_entry, only: [:edit, :update, :destroy]
    before_filter :columns_for_list, only: [:index]
    before_filter :columns_for_form, except: [:index]

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
        @resource = resource_model
      end

      def set_entry
        @entry = @resource.find(params[:id])
      end

      def columns_for_list
        @columns_for_list = @resource.columns
      end

      def columns_for_form
        @columns_for_form = @resource.columns.reject do |column|
          %w(id created_at updated_at).include?(column.name)
        end
      end

      def resource_model
        params[:controller].sub(/^cms\//, '').classify.safe_constantize
      end

      def resource_params
        params.require(@resource.model_name.element).permit(*@columns_for_form.map(&:name))
      end
  end
end
