class Adminable::UsersController < Adminable::ResourcesController
  set_attributes do |attributes|
    attributes.set(
      :encrypted_password,
      :reset_password_token,
      :reset_password_sent_at,
      :remember_created_at,
      :sign_in_count,
      :current_sign_in_at,
      :last_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_ip,
      index: false,
      form: false
    )

    attributes.set :email, search: true

    attributes.add :password, :string, index: false
  end
end
