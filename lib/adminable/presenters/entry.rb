module Adminable
  module Presenters
    class Entry < SimpleDelegator
      include Adminable::Engine.routes.url_helpers
      include Adminable::Presenters::Helpers

      def initialize(entry, field: nil)
        super(entry)
        @field = field
        @value = entry.public_send(field.name) if field
      end

      def to_name
        %i(name title email login id).each do |method_name|
          begin
            return __getobj__.public_send(method_name)
          rescue NoMethodError
            next
          end
        end
      end

      def link_to_self
        return to_name unless resource

        view.link_to(
          to_name,
          edit_polymorphic_path(__getobj__),
          target: '_blank'
        )
      end

      def link_to_delete
        view.link_to(
          I18n.t('adminable.buttons.delete'),
          polymorphic_path(__getobj__),
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
          edit_polymorphic_path(__getobj__),
          class: 'label label-primary'
        )
      end

      def link_to_delete_small
        view.link_to(
          I18n.t('adminable.buttons.delete'),
          polymorphic_path(__getobj__),
          class: 'label label-danger',
          method: :delete,
          data: {
            confirm: I18n.t('adminable.ui.confirm')
          }
        )
      end

      def has_one_value
        association = __getobj__.association(@field.name).klass

        return Adminable::Presenters::Entry(@value).link_to_self if @value

        view.link_to(
          I18n.t(
            'adminable.ui.no_has_one',
            resource: association.model_name.human
          ),
          polymorphic_path(association)
        )
      end

      private

        def resource
          Adminable.resources.find do |resource|
            resource == Adminable::Resource.new(
              __getobj__.class.name.pluralize.underscore
            )
          end
        end
    end
  end
end
