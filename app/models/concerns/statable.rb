# frozen_string_literal: true

module Concerns
  module Statable
    include Concerns::Proxyable
    ATTRIBUTES = %i[str dex agi vit int fai patk matk pdef mdef aspd mspd hit flee].freeze

    cattr_accessor :extension_module do
      Concerns::StatQueryable
    end

    def self.extended(base)
      ATTRIBUTES.each do |attribute|
        proxify(base, attribute)
      end
    end
  end
end
