# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Resourceable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(Concerns::Resourceable) }

    Concerns::Resourceable.attributes.each do |attribute, identity_value|
      let(:attribute) { attribute }
      let(:identity_value) { identity_value }
      include_context 'class_accessors_identity'
      include_context 'class_accessors_root_state'
    end
  end
end
