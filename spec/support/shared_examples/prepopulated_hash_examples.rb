# frozen_string_literal: true

RSpec.shared_examples 'prepopulated_hash' do
  let(:pop_hash) { input.dup.extend(Concerns::Statable) }

  described_class.attributes.sample.each do |attribute, identity_value|
    it { expect(pop_hash.send("#{attribute}!")).to eq(input[attribute] || identity_value) }
  end
end
