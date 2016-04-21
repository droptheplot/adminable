describe Adminable::Attributes::Association do
  let!(:reflection) do
    User.reflect_on_all_associations.find { |a| a.name == :blog_posts }
  end
  let!(:association) { Adminable::Attributes::Association.new(reflection) }
  let!(:blog_post) { FactoryGirl.create(:blog_post) }

  describe '@model' do
    it 'has ResourceConcern included' do
      expect(association.model.first).to respond_to(:adminable)
    end
  end

  describe '#options_for_select' do
    it 'returns all entries for association model' do
      expect(association.options_for_select).to match_array(blog_post)
    end
  end
end
