describe Adminable::FieldCollector do
  let!(:collection) { Adminable::FieldCollector.new(Blog::Comment) }

  describe '#all' do
    it 'returns fields from given model' do
      expected_classes = %w(
        Adminable::Fields::Integer.new(:id)
        Adminable::Fields::Text.new(:body)
        Adminable::Fields::Datetime.new(:created_at)
        Adminable::Fields::Datetime.new(:updated_at)
        Adminable::Fields::BelongsTo.new(:blog_post)
        Adminable::Fields::BelongsTo.new(:user)
      )

      expect(collection.all).to eq(expected_classes)
    end
  end

  describe '#resolve' do
    it 'returns field class from given type' do
      expect(collection.instance_eval { resolve(:string, :title) }).to eq(
        'Adminable::Fields::String.new(:title)'
      )
    end
  end
end
