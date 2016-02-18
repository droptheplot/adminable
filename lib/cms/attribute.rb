module Cms
  class Attribute
    attr_accessor :name, :type, :key, :class

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @key = options[:key] || @name
      @class = options[:class]
    end
  end
end
