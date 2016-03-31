module Adminable
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_entry, only: [:edit, :update, :destroy]

    before_action do
      append_view_path Adminable::Engine.root.join('app/views/adminable', controller_name)
      append_view_path Adminable::Engine.root.join('app/views/adminable/resources')
    end

    def index
      @q = @resource.model.ransack(params[:q])
      @entries = @q.result.includes(*@resource.includes).all
                   .page(params[:page]).per(25)
    end

    def new
      @entry = @resource.model.new
    end

    def edit
    end

    def create
      @entry = @resource.model.new(resource_params)

      if @entry.save
        redirect_to polymorphic_path(@resource.model),
                    notice: t(
                      'adminable.resources.created',
                      resource: @resource.model.model_name.human
                    )
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :new
      end
    end

    def update
      if @entry.update(resource_params)
        redirect_to polymorphic_path(@resource.model),
                    notice: t(
                      'adminable.resources.updated',
                      resource: @resource.model.model_name.human
                    )
      else
        flash.now[:alert] = @entry.errors.full_messages
        render :edit
      end
    end

    def destroy
      @entry.destroy

      redirect_to polymorphic_path(@resource.model),
                  notice: t(
                    'adminable.resources.deleted',
                    resource: @resource.model.model_name.human
                  )
    end

    private

      def set_resource
        @resource = Adminable::Configuration.find_resource(resource_model).clone

        @resource.attributes.index = index_attributes
        @resource.attributes.form = form_attributes
      end

      def set_entry
        @entry = @resource.model.find(params[:id])
      end

      def index_attributes
        @resource.attributes.index
      end

      def form_attributes
        @resource.attributes.form
      end

      def resource_model
        controller_path.sub(%r{^adminable/}, '')
      end

      def resource_params
        params.require(@resource.model.model_name.param_key).permit(
          *@resource.attributes.form.values.map(&:strong_parameter)
        )
      end
  end
end
