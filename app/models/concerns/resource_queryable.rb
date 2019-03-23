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
  end
end
