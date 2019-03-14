# frozen_string_literal: true

module Concerns
  module Proxyable
    extend ActiveSupport::Concern

    class_methods do
      def proxify(base, attribute)
        initial_value = base[attribute] || extension_module.identity_value
        base[attribute] = {}.extend(extension_module)
        base.tap do |t|
          t.define_singleton_method(attribute) { Proxy.new(base, attribute) }
          t.define_singleton_method("#{attribute}=") { |x| Proxy.new(base, attribute).assign_root(x) }
          t.define_singleton_method("#{attribute}!") { Proxy.new(base, attribute).aggregate }
          t.send("#{attribute}=", initial_value)
        end
      end
    end
  end
end
