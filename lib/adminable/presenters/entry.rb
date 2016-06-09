module Adminable
  module Presenters
    class Entry < SimpleDelegator
      include Adminable::Engine.routes.url_helpers
      include Adminable::Presenters::Helpers

      def initialize(entry, field: nil)
        @entry = entry
        @field = field
        @value = entry.public_send(field.name) if field
      end

      def to_name
        %i(name title email login id).each do |method_name|
          begin
            return entry.public_send(method_name)
          rescue NoMethodError
            next
          end
        end
      end

      def link_to_self
        return to_name unless resource

        view.link_to(
          to_name,
          edit_polymorphic_path(entry),
          target: '_blank'
        )
      end

      def link_to_delete
        view.link_to(
          I18n.t('adminable.buttons.delete'),
          polymorphic_path(@entry),
          class: 'btn btn-danger-outline pull-xs-right',
          method: :delete,
          data: {
            confirm: I18n.t('adminable.ui.confirm')
          }
        )
      end

      def link_to_edit_small
        view.link_to(
          I18n.t('adminable.buttons.edit'),
          edit_polymorphic_path(entry),
          class: 'label label-primary'
        )
      end

      def link_to_delete_small
        view.link_to(
          I18n.t('adminable.buttons.delete'),
          polymorphic_path(entry),
          class: 'label label-danger',
          method: :delete,
          data: {
            confirm: I18n.t('adminable.ui.confirm')
          }
        )
      end

      def has_one_value
        association = @entry.association(@field.name).klass

        if @value
          Adminable::Presenters::Entry(@value).link_to_self
        else
          view.link_to(
            I18n.t(
              'adminable.ui.no_has_one',
              resource: association.model_name.human
            ),
            polymorphic_path(association),
          )
        end
      end

      def method_missing(method_name, *args, &block)
        entry.public_send(method_name, *args, &block)
      end

      def respond_to_missing?(method_name, *)
        entry.respond_to?(method_name)
      end

      private

        attr_accessor :entry

        def resource
          Adminable::Configuration.resources.find do |resource|
            resource == Adminable::Resource.new(
              entry.class.name.pluralize.underscore
            )
          end
        end
    end
  end
end
