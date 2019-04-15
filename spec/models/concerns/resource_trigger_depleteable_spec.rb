require 'rails_helper'

RSpec.describe Concerns::ResourceTriggerDepleteable, type: :concern do
  let(:input) { {} }
  let(:resource) { input.application_modules.select { |k, v| v == described_class }.first[0] }
  let(:rand_usage) { rand(1..30) }
  let(:action) { input.send(resource).activate(rand_usage) }

  before { input.extend(Concerns::Resourceable) }

  context 'with successful activation' do
    before { input.send("#{resource}=", rand_usage * 2) }

    it { expect { action }.to change { input.send("#{resource}!") }.from(rand_usage * 2).to(0) }
    it { expect(action).to eq( { consumed: rand_usage * 2, remainder: 0 })}
  end

  context 'with failed activation' do
    it { expect(action).to eq(false) }
  end
end