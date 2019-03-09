# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  subject(:blank_hash) { {} }

  context 'with blank hash' do
    before { blank_hash.extend(Concerns::Statable) }

    Concerns::Statable::ATTRIBUTES.each do |attribute|
      it { is_expected.to respond_to(attribute) }
      it "updates base value of #{attribute}" do
        rand_base = rand(1..100)
        root_accessor = blank_hash[attribute].root_accessor
        identity_value = blank_hash[attribute].identity_value
        expect do
          blank_hash.send("#{attribute}=", rand_base)
        end.to change{blank_hash[attribute]}.from({root_accessor => identity_value}).to({root_accessor => rand_base})
      end
      it "fetches total" do
        expect(blank_hash.send("#{attribute}!")).to eq(blank_hash[attribute].identity_value)
      end
      #it { expect(blank_hash.send(attribute)).to eq(Concerns::Statable::DEFAULT_VALUE) }
    end
  end
end
