# frozen_string_literal: true

module Concerns
  module Augmentable
    extend ActiveSupport::Concern

    def method_missing(method_name, *args)
      case method_name[-1]
      when '='
        attribute_name = method_name[0..-2]
        assign_value(attribute_name, args.first)
      else
        self[method_name] || 0
      end
    end

    def active_values
      reject { |k, _v| k.to_s.start_with?('__') }.values
    end

    private

    def cached_accessor(name)
      "__#{name}".to_sym
    end

    def assign_value(name, value)
      self[name.to_sym] = value
      self[cached_accessor(name)] = value
    end

    def cached_value(name)
      self[cached_accessor(name)]
    end
  end
end
