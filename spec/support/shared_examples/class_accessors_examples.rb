# frozen_string_literal: true

RSpec.shared_examples 'class_accessors_identity' do
  it { expect(input).to respond_to(attribute) }
  it { expect(input[attribute].root_accessor).to be_a(Symbol) }
  it { expect(input[attribute].root).to eq(identity_value) }
  it { expect(input[attribute].identity_value).to eq(identity_value) }

  it 'rejects modification to set identity value' do
    expect do
      input[attribute].send('identity_value=', 99)
    end.not_to(change { input[attribute].identity_value })
  end
end

RSpec.shared_examples 'class_accessors_root_state' do
  it 'updates base value' do
    root_accessor = input[attribute].root_accessor
    rand_base = rand(identity_value + 1..100)
    expect { input.send("#{attribute}=", rand_base) }.to change {
      input[attribute][root_accessor]
    }.from(identity_value).to(rand_base)
  end
end
