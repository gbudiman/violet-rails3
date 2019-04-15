require 'rails_helper'

RSpec.describe Concerns::ResourceTriggerable, type: :concern do
  let(:input) { {} }

  before { input.extend(Concerns::Resourceable) }

  it do
    input.virtue.activate(30)
  end
end