module Concerns
  module StatQueryable
    extend ActiveSupport::Concern
    cattr_accessor :root_accessor do
      :base
    end
    cattr_accessor :identity_value do
      1
    end

    def self.extended(base)
      base.assign_root(identity_value)
    end

    def assign_root(value)
      self[root_accessor] = value
    end

    def fetch_aggregate
      self.values.reduce(0) { |a, b| a + b }
    end

    def disable(*args)
      args.map { |x| self[x] = 0 if self[x].present? }
      fetch_aggregate
    end

    def method_missing(method_name, *args, &block)
      case method_name[-1]
      when '='
        self[method_name[0..-2].to_sym] = args.first
      else
        self[method_name] || 0
      end
    end
  end
end