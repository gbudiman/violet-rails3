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
      active_values.reduce(0) { |a, b| a + b }.clamp(identity_value, 255)
    end

    def return_value
      capacity
    end
  end
end
