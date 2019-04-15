# frozen_string_literal: true

module Concerns
  module Proxyable
    extend ActiveSupport::Concern

    class_methods do
      def extended(base)
        base.attributes.each do |attribute, identity_value|
          initial_value = base[attribute] || identity_value
          base[attribute] = {}.extend(extension_module)
          base.tap do |t|
            t.define_singleton_method(attribute) { Proxy.new(base, attribute) }
            t.define_singleton_method("#{attribute}=") { |x| Proxy.new(base, attribute).assign_root(x) }
            t.define_singleton_method("#{attribute}!") { Proxy.new(base, attribute).aggregate }
            t.send("#{attribute}=", initial_value)
            t.send(attribute).identity_value = identity_value

            t[attribute].extend(t.application_modules[attribute]) if t.application_modules&.key?(attribute)
          end
        end
      end
    end
  end
end
