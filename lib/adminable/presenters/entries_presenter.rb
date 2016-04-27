module Adminable
  class EntriesPresenter
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

    def initialize(relation, view)
      @relation = relation
      @collection = relation.map do |entry|
        Adminable::EntryPresenter.new(entry, view)
      end
    end
  end
end
