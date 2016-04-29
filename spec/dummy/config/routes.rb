Rails.application.routes.draw do
  mount Adminable::Engine => '/admin'

  devise_for :users

  root 'application#welcome'
end
