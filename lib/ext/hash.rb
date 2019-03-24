# frozen_string_literal: true

class Hash
  def sample(n = 3) # rubocop:disable Naming/UncommunicativeMethodParamName
    keys.sample(n).each_with_object({}) { |x, m| m[x] = self[x] }
  end
end
