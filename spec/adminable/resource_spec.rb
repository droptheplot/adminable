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

  describe '#human' do
    I18n.default_locale = :ru

    describe 'translation exists' do
      it 'returns localized name for resource' do
        expect(Adminable::Resource.new('blog/comments').human).to eq('Comments')
      end
    end

    describe 'translation does not exists' do
      it 'returns pluralized model name' do
        expect(Adminable::Resource.new('users').human).to eq('Users')
      end
    end

    I18n.default_locale = :en
  end
end
