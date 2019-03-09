class Proxy
  delegate_missing_to :@accessor

  def initialize(ancestor, accessor)
    @ancestor = ancestor
    @accessor = ancestor[accessor]
  end
end