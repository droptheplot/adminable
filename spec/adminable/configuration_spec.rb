describe Adminable::Configuration do
  describe '#resources' do
    it 'return array of resources' do
      resources = Adminable::Configuration.resources

      expect(resources).to all(be_a(Adminable::Resource))
      expect(resources.map(&:name)).to eq(%w(blog/comments blog/posts users))
    end
  end
end
