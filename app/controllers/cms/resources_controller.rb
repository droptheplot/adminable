module Cms
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_entry, only: [:edit, :update, :destroy]

    before_action do
      append_view_path File.join('app/views/cms', controller_name)
      append_view_path Cms::Engine.root.join('app/views/cms/resources')
    end

    def index
      @entries = @resource.all.page(params[:page]).per(20)
    end

    def new
      @entry = @resource.new
    end

    def edit
    end

    def create
      @entry = @resource.new(resource_params)

      if @entry.save
        redirect_to polymorphic_path(@resource), notice: 'Successfully Created.'
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :new
      end
    end

    def update
      if @entry.update(resource_params)
        redirect_to polymorphic_path(@resource), notice: 'Successfully Updated.'
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :edit
      end
    end

    def destroy
      @entry.destroy

      redirect_to polymorphic_path(@resource), notice: 'Successfully Destroyed.'
    end

    private

      def set_resource
        @resource = resource_model.extend(Cms::Resource)

        @resource.attributes_for_index = attributes_for_index
        @resource.attributes_for_form = attributes_for_form
      end

      def set_entry
        @entry = @resource.find(params[:id])
      end

      def attributes_for_index
        @resource.attributes_for_index
      end

      def attributes_for_form
        @resource.attributes_for_form
      end

      def resource_model
        controller_name.classify.constantize
      end

      def resource_params
        params.require(@resource.model_name.param_key).permit(
          *@resource.attributes_for_form.map(&:strong_parameter)
        )
      end
  end
end
