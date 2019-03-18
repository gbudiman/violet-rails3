# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Resourceable, type: :concern do
  context 'with blank hash' do
    subject(:blank_hash) { {} }

    before { blank_hash.extend(Concerns::Resourceable) }

    Concerns::Resourceable.attributes.each do |attribute|
      let(:attribute) { attribute }
      include_context 'class_accessors_identity' do
        let(:root_accessor) { :current }
        let(:identity_value) { 0 }
      end
    end
  end
end
