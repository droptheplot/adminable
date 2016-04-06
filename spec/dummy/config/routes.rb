Rails.application.routes.draw do
  mount Adminable::Engine => '/adminable'

  devise_for :users

  root 'application#welcome'
end
