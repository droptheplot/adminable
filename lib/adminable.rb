require 'adminable/engine'
require 'adminable/configuration'
require 'adminable/errors'

require 'adminable/resource'

require 'adminable/presenters/base_presenter'
require 'adminable/presenters/entry_presenter'
require 'adminable/presenters/entries_presenter'

require 'adminable/attributes/collection'
require 'adminable/attributes/association'

require 'adminable/attributes/base'

require 'adminable/attributes/types/belongs_to'
require 'adminable/attributes/types/boolean'
require 'adminable/attributes/types/date'
require 'adminable/attributes/types/datetime'
require 'adminable/attributes/types/decimal'
require 'adminable/attributes/types/float'
require 'adminable/attributes/types/has_many'
require 'adminable/attributes/types/integer'
require 'adminable/attributes/types/string'
require 'adminable/attributes/types/text'
require 'adminable/attributes/types/time'
require 'adminable/attributes/types/timestamp'

require 'haml-rails'
require 'sass-rails'
require 'jquery-rails'
require 'bootstrap'
require 'rails-assets-tether'
require 'kaminari'
require 'ransack'

module Adminable
end
