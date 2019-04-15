# frozen_string_literal: true

module Concerns
  module ResourceTriggerable 
    extend ActiveSupport::Concern

    class InsufficientResource < StandardError
    end

    def activate(amount, deplete_remainder: false)
      if self! < amount
        raise InsufficientResource
      end
    end
  end
end
