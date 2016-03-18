module Cms
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_entry, only: [:edit, :update, :destroy]

    before_action do
      append_view_path Cms::Engine.root.join('app/views/cms', controller_name)
      append_view_path Cms::Engine.root.join('app/views/cms/resources')
    end

    def index
      @entries = @resource.model.includes(*@resource.includes).all
        .page(params[:page]).per(20)
    end

    def new
      @entry = @resource.model.new
    end

    def edit
    end

    def create
      @entry = @resource.model.new(resource_params)

      if @entry.save
        redirect_to polymorphic_path(@resource.model), notice: 'Successfully Created.'
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :new
      end
    end

    def update
      if @entry.update(resource_params)
        redirect_to polymorphic_path(@resource.model), notice: 'Successfully Updated.'
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :edit
      end
    end

    def destroy
      @entry.destroy

      redirect_to polymorphic_path(@resource.model), notice: 'Successfully Destroyed.'
    end

    private

      def set_resource
        @resource = Cms::Resource.new(resource_model)

        @resource.index_attributes = index_attributes
        @resource.form_attributes = form_attributes
      end

      def set_entry
        @entry = @resource.model.find(params[:id])
      end

      def index_attributes
        @resource.index_attributes
      end

      def form_attributes
        @resource.form_attributes
      end

      def resource_model
        controller_name.classify.constantize
      end

      def resource_params
        params.require(@resource.model.model_name.param_key).permit(
          *@resource.form_attributes.values.map(&:strong_parameter)
        )
      end
  end
end
