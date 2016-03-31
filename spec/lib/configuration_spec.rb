describe Cms::Configuration do
  describe '#resources' do
    it 'return array of resources' do
      resources = Cms::Configuration.resources

      expect(resources).to all(be_a(Cms::Resource))
      expect(resources.map(&:name)).to eq(%w(blog/comments blog/posts users))
    end
  end

  describe '#find_resource' do
    it 'return certain resource' do
      blog_posts_resource = Cms::Configuration.find_resource('blog/posts')

      expect(blog_posts_resource).to be_a(Cms::Resource)
      expect(blog_posts_resource.model).to eq(Blog::Post)
    end
  end
end
