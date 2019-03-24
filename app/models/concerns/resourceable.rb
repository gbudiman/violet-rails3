# frozen_string_literal: true

module Concerns
  module Resourceable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::ResourceQueryable
    end

    # Phaseable: 2-phase. Accumulation and expenditure phase
    # Accumulateable: accumulation by certain actions
    #

    cattr_accessor :attributes do
      {
        hp: 10,
        ap: 100,
        limit: 0, # Phaseable #SkillPartialable #ShieldBlockAccumulateable
        trance: 0, # Phaseable #SkillPartialable #LowHealthAccumulateable
        orb: 0, # OrbSummonAccumulateable
        impulse: 0, # ImpulsiveSkillAccumulateable #SkillPartialable #DirectUsable
        malice: 0, # FlankAttackAccumulateable #SkillPartialable #DirectUsable
        mana: 0, # PotionAccumulateable #DirectUsable
        soul: 0, # SoulExtractionAccumulateable #DirectUsable
        gestalt: 0, # PhysicalAttackAccumulateable #DirectUsable
        prayer: 0, # PrayerSkillAccumulateable #DirectUsable
        weight: 10
      }
    end
  end
end
