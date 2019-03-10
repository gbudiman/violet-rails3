# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  subject(:blank_hash) { {} }

  context 'with blank hash' do
    before { blank_hash.extend(Concerns::Statable) }

    Concerns::Statable::ATTRIBUTES.each do |attribute|
      it { is_expected.to respond_to(attribute) }
      it "updates base value of #{attribute}" do
        root_accessor = blank_hash[attribute].root_accessor
        identity_value = blank_hash[attribute].identity_value
        rand_base = rand(identity_value+1..100)
        expect{ blank_hash.send("#{attribute}=", rand_base) }.to change{
          blank_hash[attribute]
        }.from({root_accessor => identity_value}).to({root_accessor => rand_base})
      end

      context 'with augmented member' do
        let(:rand_augment) { rand(1..30) }

        before do
          blank_hash.send(attribute).augment = rand_augment
        end

        it "fetches total" do
          expect(blank_hash.send("#{attribute}!")).to eq(blank_hash[attribute].identity_value + rand_augment)
        end
      end
      #it { expect(blank_hash.send(attribute)).to eq(Concerns::Statable::DEFAULT_VALUE) }
    end
  end
end
