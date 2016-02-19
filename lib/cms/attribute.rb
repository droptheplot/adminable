module Cms
  class Attribute
    attr_accessor :name, :type, :key, :klass

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @key = options[:key] || @name
      @klass = options[:klass]
    end
  end
end
