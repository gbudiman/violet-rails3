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

    def self!
      root
    end

    def consume(amount, deplete_remainder: false)
      consumed = deplete_remainder ? self[root_accessor] : amount
      self[root_accessor] -= consumed
      consumed
    end

    def root
      self[root_accessor]
    end

    def assign_root(value)
      self[root_accessor] = value
    end

    def disable(*args)
      args.map { |x| self[x] = 0 if self[x].present? }
      yield if block_given?
      return_value
    end

    def enable(*args)
      args.map { |x| self[x] = cached_value(x) if self[x].present? }
      return_value
    end

    def active_values
      reject { |k, _v| k.to_s.start_with?('__') }.values
    end

    def identity_value
      self[:__identity_value]
    end

    def identity_value=(value)
      self[:__identity_value] ||= value
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
