class Hash
  def sample(n=3)
    self.keys.sample(n).each_with_object({}) { |x, m| m[x] = self[x] }
  end
end