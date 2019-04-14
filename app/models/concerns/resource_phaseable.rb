module Concerns
  module ResourcePhaseable
    attr_accessor :phase_state # enum: %i[filling_up in_use]

    class PhaseChangeError < StandardError
    end

    included do
      phase_state = :filling_up
    end

    def activate(val)
      val ? _activate : _deactivate
    end

    private

    def _activate
      raise PhaseChangeError if phase_state == :in_use

      phase_state = :in_use
    end

    def _deactivate
      phase_state = :filling_up
    end
  end
end