require 'rails_helper'

RSpec.describe Concerns::Resourceable, type: :concern do
  context 'with blank hash' do
    subject(:blank_hash) { {} }

    before { blank_hash.extend(Concerns::Resourceable) }

    Concerns::Resourceable.attributes.each do |attribute|
      it { is_expected.to respond_to(attribute) }
    end
  end
end