describe Adminable::ApplicationController do
  routes { Adminable::Engine.routes }

  describe '#welcome' do
    it 'redirects to the first resource' do
      get :welcome
      expect(response).to redirect_to(blog_comments_path)
    end
  end
end
