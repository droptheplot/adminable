module Adminable
  module Extensions
    module Devise
      extend ActiveSupport::Concern

      included do
        set_attributes do |attributes|
          attributes.set :encrypted_password, index: false, form: false
          attributes.set :reset_password_token, index: false
          attributes.set :reset_password_sent_at, index: false
          attributes.set :remember_created_at, index: false
          attributes.set :sign_in_count, index: false
          attributes.set :current_sign_in_at, index: false
          attributes.set :last_sign_in_at, index: false
          attributes.set :current_sign_in_ip, index: false
          attributes.set :last_sign_in_ip, index: false
          attributes.set :email, search: true

          attributes.add :password, :string, index: false
        end
      end
    end
  end
end
