describe Adminable::Resource do
  describe '#route' do
    it 'returns correct route' do
      expect(Adminable::Resource.new('blog/posts').route).to eq('blog_posts')
    end
  end

  describe '#==' do
    it 'returns true for resource with same name' do
      expect(Adminable::Resource.new('users')).to eq(
        Adminable::Resource.new('users')
      )
    end
  end
end
