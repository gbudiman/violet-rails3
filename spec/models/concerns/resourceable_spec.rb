# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Concerns::Resourceable, type: :concern do
  context 'with blank hash' do
    let(:input) { {} }

    before { input.extend(Concerns::Resourceable) }

    Concerns::Resourceable.attributes.each do |attribute|
      let(:attribute) { attribute }
      include_context 'class_accessors_identity'
    end
  end
end
