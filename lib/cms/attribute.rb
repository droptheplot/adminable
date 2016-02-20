module Cms
  class Attribute
    attr_accessor :name, :type, :key, :klass, :strong_parameter

    def initialize(name, type, options = {})
      @name = name
      @type = type.to_sym
      @key = options[:key] || @name
      @klass = options[:klass]
    end

    def key
      if @type === :has_many
        "#{ @name.to_s.singularize }_ids"
      else
        @key
      end
    end

    def strong_parameter
      if @type === :has_many
        { self.key => [] }
      else
        self.key
      end
    end
  end
end
