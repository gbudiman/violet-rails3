# frozen_string_literal: true

module Concerns
  module Statable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::StatQueryable
    end

    cattr_accessor :attributes do
      %i[str dex agi vit int fai patk matk pdef mdef aspd mspd hit flee].freeze
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
