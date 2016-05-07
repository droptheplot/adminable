describe Adminable::Presenters::Entries, type: :view do
  before { FactoryGirl.create_list(:user, 10) }

  let(:users) { User.all }
  let(:entries) { Adminable::Presenters::Entries.new(users) }

  describe '#to_s' do
    it 'returns list of links for given entries' do
      list = entries.to_s
      limit = Adminable::Presenters::Entries::ENTRIES_LIMIT

      users.first(limit).each do |user|
        expect(list).to have_link(
          user.email,
          href: "/admin/users/#{user.id}/edit"
        )
      end
    end
  end

  describe '#collection_size_residue' do
    it 'returns size of the remaining entries' do
      expect(entries.instance_eval { collection_size_residue }).to eq(5)
    end
  end
end
