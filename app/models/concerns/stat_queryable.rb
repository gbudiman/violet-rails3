module Concerns
  module StatQueryable
    extend ActiveSupport::Concern
    cattr_accessor :root_accessor do
      :base
    end

    def assign_root(value)
      self[root_accessor] = value
    end

    def fetch_aggregate
      self.values.reduce(0) { |a, b| a + b }
    end
  end
end