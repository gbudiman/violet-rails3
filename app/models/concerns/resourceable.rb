# frozen_string_literal: true

module Concerns
  module Resourceable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::ResourceQueryable
    end

    cattr_accessor :attributes do
      {
        hp: 10,
        ap: 100,
        virtue: 0, # Triggerable
        trance: 0, # Phaseable #SkillPartialable #LowHealthAccumulateable
        orb: 0, # Triggerable
        impulse: 0,
        malice: 0,
        mana: 0,
        soul: 0,
        gestalt: 0,
        prayer: 0,
        weight: 10
      }
    end

    cattr_accessor :application_modules do
      {
        virtue: Concerns::ResourceTriggerable
      }
    end
  end
end
