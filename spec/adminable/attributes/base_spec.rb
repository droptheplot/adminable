describe Adminable::Fields::Base do
  describe '#initialize' do
    it 'raises an error' do
      expect { Adminable::Fields::Base.new('title') }.to raise_error
    end
  end

  let(:title) { Adminable::Fields::String.new('title') }

  describe Adminable::Fields::String do
    describe '#ransack_name' do
      it 'returns correct string for ransack' do
        expect(title.ransack_name).to eq('title_cont')
      end
    end

    describe '#type' do
      it 'returns correct field type' do
        expect(title.type).to eq(:string)
      end
    end

    describe '#index_partial_path' do
      it 'returns correct path for index partial' do
        expect(title.index_partial_path).to eq('index/string')
      end
    end

    describe '#form_partial_path' do
      it 'returns correct path for form partial' do
        expect(title.form_partial_path).to eq('form/string')
      end
    end
  end
end
