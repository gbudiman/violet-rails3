# frozen_string_literal: true

module Concerns
  module StatQueryable
    include Concerns::Augmentable
    extend ActiveSupport::Concern

    cattr_accessor :root_accessor do
      :innate
    end
    cattr_accessor :identity_value do
      1
    end

    def self.extended(base)
      base.assign_root(identity_value)
    end

    def root
      self[root_accessor]
    end

    def assign_root(value)
      self[root_accessor] = value
    end

    def aggregate
      active_values.reduce(0) { |a, b| a + b }
    end

    def disable(*args)
      args.map { |x| self[x] = 0 if self[x].present? }
      aggregate
    end

    def enable(*args)
      args.map { |x| self[x] = cached_value(x) if self[x].present? }
      aggregate
    end
  end
end
