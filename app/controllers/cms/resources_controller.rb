module Cms
  class ResourcesController < ApplicationController
    before_action :set_resource
    before_action :set_attributes_for_list, only: :index
    before_action :set_attributes_for_form, only: [:new, :edit, :create, :update]
    before_action :set_entry, only: [:edit, :update, :destroy]

    before_action do
      append_view_path File.join('app/views/cms', controller_name)
      append_view_path Cms::Engine.root.join('app/views/cms/resources')
    end

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

      def set_attributes_for_list
        @attributes_for_list = attributes_for_list
      end

      def set_attributes_for_form
        @attributes_for_form = attributes_for_form
      end

      def set_entry
        @entry = @resource.find(params[:id])
      end

      def attributes_for_list
        self.class::ATTRIBUTES_FOR_LIST
      rescue NameError
        attributes.reject do |attribute|
          %w(created_at updated_at).include?(attribute.name)
        end
      end

      def attributes_for_form
        self.class::ATTRIBUTES_FOR_FORM
      rescue NameError
        attributes.reject do |attribute|
          %w(id created_at updated_at).include?(attribute.name) || attribute.type == :has_many
        end
      end

      def resource_model
        self.class::RESOURCE_MODEL
      rescue NameError
        controller_name.classify.safe_constantize
      end

      def attributes
        @attributes = []

        @attributes += @resource.columns.reject do |attribute|
          attribute.name.match(/_id$/)
        end.map do |column|
          Cms::Attribute.new(column.name, column.type)
        end

        @attributes += @resource.reflect_on_all_associations(:belongs_to).map do |association|
          Cms::Attribute.new(
            association.name,
            :belongs_to,
            key: association.foreign_key,
            klass: association.klass
          )
        end

        @attributes += @resource.reflect_on_all_associations(:has_many).map do |association|
          Cms::Attribute.new(
            association.name,
            :has_many,
            key: association.foreign_key,
            klass: association.klass
          )
        end

        @attributes
      end

      def resource_params
        params.require(@resource.model_name.element).permit(*attributes_for_form.map(&:key))
      end
  end
end
