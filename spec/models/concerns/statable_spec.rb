# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(described_class) }

    described_class.attributes.sample.each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      it_behaves_like 'class_accessors_identity'
      it_behaves_like 'class_accessors_root_state'

      context 'with augmentation' do
        let(:augment) { :almighty_blessing }
        let(:rand_augment) { rand(1..30) }
        let(:value_verifier) { :aggregate }

        it_behaves_like 'summable_members'
        it_behaves_like 'switchable_augmented_members'
      end
    end
  end

  it_behaves_like 'prepopulated_hash'
end
