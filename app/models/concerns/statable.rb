# frozen_string_literal: true

module Concerns
  module Statable
    ATTRIBUTES = %i[str dex agi vit int fai].freeze
    DEFAULT_VALUE = 1

    def self.extended(base)
      ATTRIBUTES.each do |attribute|
        base[attribute] = {}.extend(Concerns::StatQueryable)
        base.define_singleton_method(attribute) { Proxy.new(base, attribute) }
        base.define_singleton_method("#{attribute}=") { |x| base[attribute].base(x) }
        base.define_singleton_method("#{attribute}!") { Proxy.new(base, attribute).fetch }
        #base[attribute] ||= 1
      end
    end
  end
end
