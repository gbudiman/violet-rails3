# frozen_string_literal: true

class Proxy
  attr_accessor :accessor

  def initialize(ancestor, accessor)
    @ancestor = ancestor
    @accessor = ancestor[accessor]
  end

  def method_missing(method_name, *args, &block)
    accessor.send(method_name, *args, &block)
  end
end
