# frozen_string_literal: true

module Concerns
  module StatQueryable
    include Concerns::Augmentable
    extend ActiveSupport::Concern

    cattr_accessor :root_accessor do
      :current
    end
    cattr_accessor :identity_value do
      0
    end

    def aggregate
      root
    end
  end
end
