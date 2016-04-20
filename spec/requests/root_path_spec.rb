describe 'Root' do
  it 'redirects to the first resource' do
    get root_path
    expect(response).to redirect_to(blog_comments_path)
  end
end
