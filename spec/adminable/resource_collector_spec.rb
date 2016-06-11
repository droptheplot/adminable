describe Adminable::ResourceCollector do
  describe '#resources' do
    it 'return array of resources' do
      resources_paths = Adminable::Configuration.resources_paths

      resources = Adminable::ResourceCollector.new(resources_paths).resources

      expect(resources).to all(be_a(Adminable::Resource))
      expect(resources.map(&:name)).to eq(
        %w(blog/comments blog/posts profiles users)
      )
    end
  end
end
