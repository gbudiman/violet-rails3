# frozen_string_literal: true

module Concerns
  module Statable
    include Concerns::Proxyable

    cattr_accessor :extension_module do
      Concerns::StatQueryable
    end

    cattr_accessor :attributes do
      {
        str: 1,
        dex: 1,
        agi: 1,
        vit: 1,
        int: 1,
        fai: 1,
        patk: 0,
        matk: 0,
        pdef: 0,
        mdef: 0,
        aspd: 1,
        mspd: 1,
        hit: 1,
        flee: 1
      }
    end
  end
end
