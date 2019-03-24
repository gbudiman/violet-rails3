# frozen_string_literal: true

RSpec.shared_examples 'correctly_summed_member' do
  let(:expectation) do
    rand_augment + (defined?(rand_root) ? rand_root : identity_value)
  end

  it { expect(input.send("#{attribute}!")).to eq(expectation) }
end

RSpec.shared_examples 'summable_members' do
  before { input.send(attribute).send("#{augment}=", rand_augment) }

  it_behaves_like 'correctly_summed_member'

  context 'with non-identity root value' do
    let!(:rand_root) { rand(1..99) }

    before { input.send("#{attribute}=", rand_root) }

    it_behaves_like 'correctly_summed_member'
    it { expect(input.send(attribute).send(:non_existant_augment)).to eq(0) }
  end
end
