describe Adminable::Resource do
  describe '#includes' do
    context 'with association attributes' do
      resource = Adminable::Resource.new('blog/posts')

      it 'returns array of the associations' do
        expect(resource.includes).to eq(%i(user blog_comments))
      end
    end

    context 'without association attributes' do
      resource = Adminable::Resource.new('user')

      it 'returns false' do
        allow(resource.attributes).to receive(:associations).and_return([])
        expect(resource.includes).to be false
      end
    end
  end

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
