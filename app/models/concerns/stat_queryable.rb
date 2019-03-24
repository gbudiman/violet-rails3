# frozen_string_literal: true

module Concerns
  module StatQueryable
    include Concerns::Augmentable
    extend ActiveSupport::Concern

    cattr_accessor :root_accessor do
      :innate
    end

    def aggregate
      active_values.reduce(0) { |a, b| a + b }.clamp(identity_value, 255)
    end
  end
end
