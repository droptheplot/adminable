module Adminable
  class EntryPresenter < BasePresenter
    def initialize(entry)
      @entry = entry
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
      unless Adminable::Configuration.find_resource(resource_name)
        return to_name
      end

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

    def method_missing(method_name, *args, &block)
      entry.public_send(method_name, *args) { block if block_given? }
    end

    def respond_to_missing?(method_name, *)
      entry.respond_to?(method_name)
    end

    private

      attr_accessor :entry

      def resource_name
        entry.class.name.pluralize.underscore
      end
  end
end
