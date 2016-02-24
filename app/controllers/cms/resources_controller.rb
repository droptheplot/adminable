module Cms
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_attributes_for_index, only: :index
    before_action :set_attributes_for_form, only: [:new, :edit, :create, :update]
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
        @resource = resource_model
      end

      def set_attributes_for_index
        @attributes_for_index = attributes_for_index
      end

      def set_attributes_for_form
        @attributes_for_form = attributes_for_form
      end

      def set_entry
        @entry = @resource.find(params[:id])
      end

      def attributes_for_index
        self.class::ATTRIBUTES_FOR_INDEX
      rescue NameError
        attributes.reject do |attribute|
          %w(created_at updated_at).include?(attribute.name)
        end
      end

      def attributes_for_form
        self.class::ATTRIBUTES_FOR_FORM
      rescue NameError
        attributes.reject do |attribute|
          %w(id created_at updated_at).include?(attribute.name)
        end
      end

      def resource_model
        self.class::RESOURCE_MODEL
      rescue NameError
        controller_name.classify.safe_constantize
      end

      def attributes
        @attributes = Cms::Resource.collect_attributes(@resource)
      end

      def resource_params
        params.require(@resource.model_name.element).permit(*attributes_for_form.map(&:strong_parameter))
      end
  end
end
