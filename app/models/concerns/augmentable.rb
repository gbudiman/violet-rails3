# frozen_string_literal: true

module Concerns
  module Augmentable
    extend ActiveSupport::Concern

    class_methods do
      def extended(base)
        base.assign_root(identity_value)
      end
    end

    def method_missing(method_name, *args)
      case method_name[-1]
      when '='
        attribute_name = method_name[0..-2]
        assign_value(attribute_name, args.first)
      else
        self[method_name] || 0
      end
    end

    def root
      self[root_accessor]
    end

    def assign_root(value)
      self[root_accessor] = value
    end

    def disable(*args)
      args.map { |x| self[x] = 0 if self[x].present? }
      aggregate
    end

    def enable(*args)
      args.map { |x| self[x] = cached_value(x) if self[x].present? }
      aggregate
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
