RSpec.shared_examples 'augmentable_members' do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(described_class) }

    described_class.attributes.sample(1).each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      include_context 'class_accessors_identity'
      include_context 'class_accessors_root_state'

      context 'with augmentation' do
        let(:augment) { :almighty_blessing }
        let(:rand_augment) { rand(1..30) }
        let(:value_verifier) { :capacity }

        it_behaves_like 'switchable_augmented_members'
        #it_behaves_like 'latchable_members'
        # byebug
        # it_behaves_like extra_test
      end
    end
  end

  it_behaves_like 'prepopulated_hash'
end