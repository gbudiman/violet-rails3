# frozen_string_literal: true

RSpec.shared_examples 'class_accessors_identity' do
  it { is_expected.to respond_to(attribute) }
  it { expect(subject[attribute].root_accessor).to eq(root_accessor) }
  it { expect(subject[attribute].identity_value).to eq(identity_value) }
  it { expect(subject[attribute].root).to eq(identity_value) }
end

RSpec.shared_examples 'class_accessors_root_state' do
  it 'updates base value' do
    root_accessor = subject[attribute].root_accessor
    identity_value = subject[attribute].identity_value
    rand_base = rand(identity_value + 1..100)
    expect { subject.send("#{attribute}=", rand_base) }.to change {
      subject[attribute]
    }.from(root_accessor => identity_value).to(root_accessor => rand_base)
  end
end
