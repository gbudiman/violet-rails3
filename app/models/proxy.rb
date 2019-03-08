class Proxy
  def initialize(ancestor, accessor)
    @ancestor = ancestor
    @accessor = ancestor[accessor]
  end

  def fetch_aggregate
    @accessor.fetch_aggregate
  end

  def assign_root(value)
    @accessor.assign_root(value)
  end
end