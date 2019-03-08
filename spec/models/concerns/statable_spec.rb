# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  subject(:blank_hash) { {} }

  context 'with blank hash' do
    before { blank_hash.extend(Concerns::Statable) }

    Concerns::Statable::ATTRIBUTES.each do |attribute|
      it { is_expected.to respond_to(attribute) }
      it "updates base value of #{attribute}" do
        expect do
          blank_hash.send("#{attribute}=", 31)
        end.to change{blank_hash[attribute]}.from({}).to({base: 31})
      end
      it "fetches total" do
        expect(blank_hash.send("#{attribute}!")).to eq(0)
      end
      #it { expect(blank_hash.send(attribute)).to eq(Concerns::Statable::DEFAULT_VALUE) }
    end
  end
end
