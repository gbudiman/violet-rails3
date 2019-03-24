# frozen_string_literal: true

RSpec.shared_examples 'switchable_augmented_members' do
  before { input.send(attribute).send("#{augment}=", rand_augment) }

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
