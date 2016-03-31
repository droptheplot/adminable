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

      xit 'returns false' do
        expect(resource.includes).to be false
      end
    end
  end

  describe '#index_attributes' do
    resource = Adminable::Resource.new('user')

    it 'returns correct hash of the resource attributes' do
      expect(resource.attributes.index).not_to include(:created_at, :updated_at)
    end
  end

  describe '#form_attributes' do
    resource = Adminable::Resource.new('user')

    it 'returns correct hash of the resource attributes' do
      expect(resource.attributes.form).not_to include(:id, :created_at, :updated_at)
    end
  end
end
