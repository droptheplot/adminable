describe Adminable::Presenters::Entry do
  let(:user) { FactoryGirl.create(:user) }
  let(:entry) { Adminable::Presenters::Entry.new(user) }

  describe '#to_name' do
    it 'returns name for entry' do
      expect(entry.to_name).to eq(user.email)
    end
  end
end
