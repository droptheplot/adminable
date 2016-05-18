class Adminable::ProfilesController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::Integer.new(:id),
			Adminable::Fields::String.new(:name),
			Adminable::Fields::Integer.new(:age),
			Adminable::Fields::Datetime.new(:created_at),
			Adminable::Fields::Datetime.new(:updated_at),
			Adminable::Fields::BelongsTo.new(:user)
    ]
  end
end
