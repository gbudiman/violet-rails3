# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'with scaffolded augmented member' do
  before { input.send(attribute).send("#{augment}=", rand_augment) }
end

RSpec.shared_examples 'summable members' do
  include_context 'with scaffolded augmented member'
  it_behaves_like 'correctly-summed member'

  context 'with non-identity root value' do
    let(:rand_root) { rand(1..99) }

    before { input.send("#{attribute}=", rand_root) }

    it_behaves_like 'correctly-summed member'
    it { expect(input.send(attribute).send(:non_existant_augment)).to eq(0) }
  end
end

RSpec.shared_examples 'correctly-summed member' do
  let(:expectation) do
    rand_augment + (defined?(rand_root) ? rand_root : identity_value)
  end

  it { expect(input.send("#{attribute}!")).to eq(expectation) }
end

RSpec.shared_examples 'actionable augmented member' do
  let(:rand_execution) { rand(1..5) }
  let(:change_amount) { post_change - pre_change }
  it do
    rand_execution.times { pre_action } if defined?(pre_action)
    expect do
      rand_execution.times { action }
    end.to change { input[attribute][augment] }.from(pre_change).to(post_change)
      .and change { input.send("#{attribute}!") }.by change_amount
  end

  it { expect(action).to eq(final_value) }
end

RSpec.shared_examples 'switchable augmented member' do
  include_context 'with scaffolded augmented member'
  it_behaves_like 'actionable augmented member' do
    let(:action) { input.send(attribute).disable(augment) }
    let(:pre_change) { rand_augment }
    let(:post_change) { 0 }
    let(:final_value) { identity_value }
  end

  describe 'then re-enables' do
    it_behaves_like 'actionable augmented member' do
      let(:pre_action) { input.send(attribute).disable(augment) }
      let(:action) { input.send(attribute).enable(augment) }
      let(:pre_change) { 0 }
      let(:post_change) { rand_augment }
      let(:final_value) { identity_value + rand_augment }
    end
  end
end

RSpec.describe Concerns::Statable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(Concerns::Statable) }

    Concerns::Statable.attributes.each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      include_context 'class_accessors_identity'
      include_context 'class_accessors_root_state'

      context 'with augmentation' do
        let(:augment) { :almighty_blessing }
        let(:rand_augment) { rand(1..30) * [-1, 1].sample }

        it_behaves_like 'summable members'
        it_behaves_like 'switchable augmented member'
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
