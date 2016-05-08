Rails.application.routes.draw do
  mount Adminable::Engine => '/admin'

  devise_for :users

  root to: redirect('/admin')
end
