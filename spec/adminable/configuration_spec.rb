describe Adminable::Configuration do
  describe '#resources' do
    it 'return array of resources' do
      resources = Adminable::Configuration.resources

      expect(resources).to all(be_a(Adminable::Resource))
      expect(resources.map(&:name)).to eq(
        %w(blog/comments blog/posts profiles users)
      )
    end
  end

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
        allow(Adminable::Configuration).to receive(:resources).and_return([])

        expect(Adminable::Configuration.redirect_root_path).to eq('/')
      end
    end
  end
end
