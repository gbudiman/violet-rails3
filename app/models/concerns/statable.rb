# frozen_string_literal: true

module Concerns
  module Statable
    ATTRIBUTES = %i[str dex agi vit int fai].freeze

    def self.extended(base)
      ATTRIBUTES.each do |attribute|
        base[attribute] = {}.extend(Concerns::StatQueryable)
        base.define_singleton_method(attribute) { Proxy.new(base, attribute) }
        base.define_singleton_method("#{attribute}=") { |x| Proxy.new(base, attribute).assign_root(x) }
        base.define_singleton_method("#{attribute}!") { Proxy.new(base, attribute).fetch_aggregate }
      end
    end
  end
end
