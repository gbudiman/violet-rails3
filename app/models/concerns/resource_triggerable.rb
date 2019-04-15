# frozen_string_literal: true

module Concerns
  module ResourceTriggerable
    extend ActiveSupport::Concern

    def activate(amount)
      return false if self! < amount

      {
        consumed: block_given? ? yield : consume(amount),
        remainder: self!
      }
    end
  end
end
