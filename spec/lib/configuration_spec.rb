describe Adminable::Configuration do
  describe '#resources' do
    it 'return array of resources' do
      resources = Adminable::Configuration.resources

      expect(resources).to all(be_a(Adminable::Resource))
      expect(resources.map(&:name)).to eq(%w(blog/comments blog/posts users))
    end
  end

  describe '#find_resource' do
    it 'return certain resource' do
      blog_posts_resource = Adminable::Configuration.find_resource('blog/posts')

      expect(blog_posts_resource).to be_a(Adminable::Resource)
      expect(blog_posts_resource.model).to eq(Blog::Post)
    end
  end
end
