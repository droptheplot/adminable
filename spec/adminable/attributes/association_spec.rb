describe Adminable::Attributes::Association do
  let!(:reflection) do
    User.reflect_on_all_associations.find { |a| a.name == :blog_posts }
  end
  let!(:association) { Adminable::Attributes::Association.new(reflection) }
  let!(:blog_post) { FactoryGirl.create(:blog_post) }

  describe '#model' do
    it 'returns association model class' do
      expect(association.model).to eq(Blog::Post)
    end
  end

  describe '#entries' do
    it 'returns EntriesPresenter with all entries for association model' do
      expect(association.entries).to be_a(Adminable::Presenters::Entries)
    end
  end
end
