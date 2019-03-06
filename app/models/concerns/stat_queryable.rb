module Concerns
  module StatQueryable
    def base(arg)
      self[:base] = arg
    end

    def fetch
      self.values.reduce(0) { |a, b| a + b }
    end
  end
end