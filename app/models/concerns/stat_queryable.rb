# frozen_string_literal: true

module Concerns
  module StatQueryable
    include Concerns::Augmentable
    extend ActiveSupport::Concern

    cattr_accessor :root_accessor do
      :innate
    end
    cattr_accessor :identity_value do
      1
    end

    def aggregate
      active_values.reduce(0) { |a, b| a + b }
    end
  end
end
