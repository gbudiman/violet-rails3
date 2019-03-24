# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(Concerns::Statable) }

    Concerns::Statable.attributes.sample.each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      include_context 'class_accessors_identity'
      include_context 'class_accessors_root_state'

      context 'with augmentation' do
        let(:augment) { :almighty_blessing }
        let(:rand_augment) { rand(1..30) }

        it_behaves_like 'summable_members'
        it_behaves_like 'switchable_augmented_members'
      end
    end
  end

  context 'with prepopulated hash' do
    let(:input) do
      {
        str: rand(1..99),
        agi: rand(1..99),
        vit: rand(1..99),
        dex: rand(1..99),
        int: rand(1..99),
        fai: rand(1..99)
      }
    end

    let!(:pop_hash) { input.dup.extend(Concerns::Statable) }

    Concerns::Statable.attributes.each do |attribute, identity_value|
      it { expect(pop_hash.send("#{attribute}!")).to eq(input[attribute] || identity_value) }
    end
  end
end
