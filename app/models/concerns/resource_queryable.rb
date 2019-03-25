# frozen_string_literal: true

module Concerns
  module ResourceQueryable
    include Concerns::Augmentable
    extend ActiveSupport::Concern

    cattr_accessor :root_accessor do
      :current
    end

    def aggregate
      root
    end

    def capacity
      active_values.reduce(0) { |a, b| a + b }.clamp(identity_value, 65_535)
    end

    def return_value
      capacity
    end

    def active_values
      reject { |k, _v| k.to_s.start_with?('__') || k == root_accessor }.values
    end

    def disable(*args)
      super { assign_root(capacity) if aggregate > capacity }
    end
  end
end
