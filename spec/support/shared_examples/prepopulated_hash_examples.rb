# frozen_string_literal: true

RSpec.shared_examples 'prepopulated_hash' do
  let(:input) do
    described_class.attributes.sample.each_with_object({}) do |(attribute, identity_value), memo|
      memo[attribute] = rand(identity_value..99)
    end
  end
  let(:pop_hash) { input.dup.extend(described_class) }

  described_class.attributes.sample.each do |attribute, identity_value|
    it { expect(pop_hash.send("#{attribute}!")).to eq(input[attribute] || identity_value) }
  end
end
