module Adminable
  class EntryPresenter
    include Adminable::Engine.routes.url_helpers

    def initialize(entry, view)
      @entry = entry
      @view = view
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

    private

      attr_accessor :entry, :view
  end
end
