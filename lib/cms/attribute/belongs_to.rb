module Cms
  module Attribute
    class BelongsTo < Base
      include Cms::Attribute::Association
    end
  end
end
