# frozen_string_literal: true

module Concerns
  module Resourceable
    include Concerns::Proxyable
    ATTRIBUTES = %i[hp ap limit trance orb impulse malice mana soul gestalt prayer weight]

    def self.extended(base)
      ATTRIBUTES.each do |attribute|
        self.proxify(base, attribute)
      end
    end
  end
end