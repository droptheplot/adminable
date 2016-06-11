describe Adminable::Configuration do
  describe '#redirect_root_path' do
    describe 'if resources exists' do
      it 'returns first resource url' do
        expect(Adminable::Configuration.redirect_root_path).to eq(
          'blog/comments'
        )
      end
    end

    describe 'if no resources exists' do
      it 'returns main app root path' do
        allow(Adminable).to receive(:resources).and_return([])

        expect(Adminable::Configuration.redirect_root_path).to eq('/')
      end
    end
  end
end
