module Adminable
  class EntriesPresenter < BasePresenter
    include Enumerable
    extend Forwardable

    def_delegators :@collection, :each, :first, :last, :empty?
    def_delegators(
      *%i(
        @relation
        current_page
        total_pages
        limit_value
        entry_name
        total_count
        offset_value
        last_page?
      )
    )

    def initialize(relation)
      @relation = relation
      @collection = relation.all.map do |entry|
        Adminable::EntryPresenter.new(entry)
      end
    end

    def to_s
      collection.map do |entry|
        view.link_to(entry.to_name, edit_polymorphic_path(entry))
      end.to_sentence.html_safe
    end

    private

      attr_accessor :relation, :collection
  end
end
