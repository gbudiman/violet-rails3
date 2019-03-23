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
  end
end
