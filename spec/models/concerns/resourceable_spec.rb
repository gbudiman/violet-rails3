# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Resourceable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(described_class) }

    Concerns::Resourceable.attributes.sample.each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      include_context 'class_accessors_identity'
      include_context 'class_accessors_root_state'

      context 'with augmentation' do
        let(:augment) { :almighty_blessing }
        let(:rand_augment) { rand(1..30) }
        let(:value_verifier) { :capacity }

        it_behaves_like 'switchable_augmented_members'
        it_behaves_like 'latchable_members'
      end
    end
  end

  it_behaves_like 'prepopulated_hash'
end
