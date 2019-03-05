# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Statable, type: :concern do
  subject(:blank_hash) { {} }

  context 'with blank hash' do
    before { blank_hash.extend(Concerns::Statable) }

    Concerns::Statable::ATTRIBUTES.each do |attribute|
      it { is_expected.to respond_to(attribute) }
      it { expect(blank_hash.send(attribute)).to eq(Concerns::Statable::DEFAULT_VALUE) }
    end
  end
end
