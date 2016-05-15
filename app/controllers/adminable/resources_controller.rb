module Adminable
  class ResourcesController < ApplicationController
    def initialize(*)
      @resource = Adminable::Configuration.resources.find do |resource|
        resource == Adminable::Resource.new(resource_model_name)
      end

      super
    end

    before_action :set_entry, only: [:edit, :update, :destroy]
    before_action :set_fields, only: [:index, :new, :edit, :create, :update]

    before_action do
      append_view_path(
        [
          Rails.root.join('app/views', controller_path),
          Rails.root.join('app/views/adminable/resources'),
          Adminable::Engine.root.join('app/views/adminable/resources')
        ]
      )
    end

    def index
      @q = @resource.model.ransack(params[:q])
      @entries = Adminable::Presenters::Entries.new(
        @q.result.includes(*includes).order(id: :desc)
                                              .page(params[:page]).per(25)
      )
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
        flash.now[:alert] = @entry.errors.full_messages.first
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
        flash.now[:alert] = @entry.errors.full_messages.first
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

      def set_entry
        entry ||= @resource.model.find(params[:id])
        @entry = Adminable::Presenters::Entry.new(entry)
      end

      def set_fields
        @fields = Adminable::Presenters::Fields.new(fields)
      end

      def resource_model_name
        controller_path.sub(%r{^adminable/}, '')
      end

      def resource_params
        params.require(@resource.model.model_name.param_key).permit(
          *fields.map(&:strong_parameter)
        )
      end

      def fields
        raise Adminable::FieldsNotDefined
      end

      def includes
        association_fields = fields.select do |field|
          %i(belongs_to has_many).include?(field.type)
        end

        association_fields.any? ? association_fields.map(&:name) : false
      end
  end
end
