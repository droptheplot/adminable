describe Adminable::Attributes::Collection do
  let!(:collection) { Adminable::Attributes::Collection.new(Blog::Comment) }

  describe '#all' do
    it 'has attributes from given model' do
      expected_classes = [
        Adminable::Attributes::Types::Integer,
        Adminable::Attributes::Types::Text,
        Adminable::Attributes::Types::Datetime,
        Adminable::Attributes::Types::Datetime,
        Adminable::Attributes::Types::BelongsTo,
        Adminable::Attributes::Types::BelongsTo
      ]

      expect(collection.all.map(&:class)).to eq(expected_classes)
    end
  end

  describe '#configure' do
    it 'yields with no args' do
      expect { |block| collection.configure(&block) }.to yield_with_no_args
    end
  end

  describe '#set' do
    it 'updates attribute params' do
      collection.set(:id, required: true)

      expect(collection.get(:id).options[:required]).to be true
    end
  end

  describe '#get' do
    it 'returns attribute from collection by name' do
      expect(collection.get(:id)).to be_a(
        Adminable::Attributes::Types::Integer
      )
    end
  end

  describe '#add' do
    it 'adds attribute to collection' do
      collection.add(:title, :string)

      expect(collection.all.last).to be_a(Adminable::Attributes::Types::String)
      expect(collection.all.last.name).to eq(:title)
    end
  end

  describe '#resolve' do
    describe 'for supported attribute' do
      it 'returns attribute class from type string' do
        expect(collection.instance_eval { resolve('string') }).to eq(
          Adminable::Attributes::Types::String
        )
      end
    end

    describe 'for not supported attribute' do
      it 'raises exception' do
        expect {
          collection.instance_eval { resolve('some_attribute_type') }
        }.to raise_error(Adminable::AttributeNotImplemented)
      end
    end
  end
end
