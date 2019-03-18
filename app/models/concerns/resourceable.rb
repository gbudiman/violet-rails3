# frozen_string_literal: true

module Concerns
  module Resourceable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::ResourceQueryable
    end

    cattr_accessor :capacities do
      {
        hp: 1,
        ap: 100,
        limit: 0,
        trance: 0,
        orb: 0,
        impulse: 0,
        malice: 0,
        mana: 0,
        soul: 0,
        gestalt: 0,
        prayer: 0,
        weight: 10
      }
    end

    cattr_accessor :attributes do
      capacities.keys
    end

    def self.extended(base)
      base.attributes.each do |attribute|
        initial_value = base[attribute] || extension_module.identity_value
        proxify(base, attribute)
        base.send("#{attribute}=", initial_value)
      end
    end
  end
end
