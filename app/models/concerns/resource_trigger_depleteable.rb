module Concerns
  module ResourceTriggerDepleteable
    include Concerns::ResourceTriggerable

    def activate(amount)
      super { consume(amount, deplete_remainder: true) }
    end
  end
end