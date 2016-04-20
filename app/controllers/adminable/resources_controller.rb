module Adminable
  class ResourcesController < ApplicationController
    def initialize(*)
      set_resource
      load_extensions

      super
    end

    before_action :set_entry, only: [:edit, :update, :destroy]

    before_action do
      append_view_path(
        [
          Adminable::Engine.root.join('app/views/adminable', controller_name),
          Adminable::Engine.root.join('app/views/adminable/resources')
        ]
      )
    end

    def index
      @q = @resource.model.ransack(params[:q])
      @entries = @q.result.includes(*@resource.includes)
                   .order(id: :desc).page(params[:page]).per(25)
    end

    def new
      @entry = @resource.model.new
    end

    def edit
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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

    # Calls from children controller class to manage resource attributes
    # @example Update attributes for Adminable::Blog::PostsController
    #   # app/controllers/adminable/blog/posts_controller.rb
    #
    #   set_attributes do |attributes|
    #     # Enables search for title column
    #     attributes.set :title, search: true
    #
    #     # Hides title from new and edit pages
    #     attributes.set :title, form: true
    #
    #     # Adds wysiwyg plugin and hides from index table
    #     attributes.set :text, wysiwyg: true, index: false
    #
    #     # Adds new attribute `password` with type `string` and some options
    #     attributes.add :password, :string, wysiwyg: true, index: false
    #   end
    def self.set_attributes
      before_action do
        @resource.attributes.configure { yield(@resource.attributes) }
      end
    end

    private

      def set_resource
        @resource = Adminable::Configuration.find_resource(resource_model)
      end

      def set_entry
        @entry = @resource.model.find(params[:id])
      end

      def resource_model
        controller_path.sub(%r{^adminable/}, '')
      end

      def resource_params
        params.require(@resource.model.model_name.param_key).permit(
          *@resource.attributes.form.map(&:strong_parameter)
        )
      end

      def load_extensions
        return unless @resource.model.method_defined?(:devise_modules)

        self.class.send(:include, Adminable::Extensions::Devise)
      end
  end
end
