# frozen_string_literal: true

RSpec.shared_examples 'class_accessors_identity' do
  it { expect(input).to respond_to(attribute) }
  it { expect(input[attribute].root_accessor).to be_a(Symbol) }
  it { expect(input[attribute].root).to eq(identity_value) }
end

RSpec.shared_examples 'class_accessors_root_state' do
  it 'updates base value' do
    root_accessor = input[attribute].root_accessor
    rand_base = rand(identity_value + 1..100)
    expect { input.send("#{attribute}=", rand_base) }.to change {
      input[attribute]
    }.from(root_accessor => identity_value).to(root_accessor => rand_base)
  end
end
