# frozen_string_literal: true

module Concerns
  module Resourceable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::ResourceQueryable
    end

    cattr_accessor :attributes do
      %i[hp ap limit trance orb impulse malice mana soul gestalt prayer weight].freeze
    end
  end
end
