class Proxy
  def initialize(ancestor, accessor)
    @ancestor = ancestor
    @accessor = ancestor[accessor]
  end

  def fetch
    @accessor.fetch
  end
end