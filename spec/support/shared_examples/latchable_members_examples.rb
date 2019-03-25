# frozen_string_literal: true

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.shared_examples 'latchable_members' do
  let(:setup_action) { input.send(attribute).send("#{augment}=", rand_augment) }

  it do
    expect do
      setup_action
    end.to change { input.send(attribute).capacity }.from(identity_value).to(identity_value + rand_augment)
      .and(not_change { input.send("#{attribute}!") })
  end

  context 'when augmented' do
    let(:fillup_action) { input.send("#{attribute}=", rand_augment + identity_value) }

    before { setup_action }

    it do
      expect do
        fillup_action
      end.to change { input.send("#{attribute}!") }.from(identity_value).to(rand_augment + identity_value)
        .and(not_change { input.send(attribute).capacity })
    end

    context 'when disabled' do
      let(:disable_action) { input.send(attribute).disable(augment) }

      before { fillup_action }

      it do
        expect do
          disable_action
        end.to change { input.send(attribute).capacity }.from(identity_value + rand_augment).to(identity_value)
          .and change { input.send("#{attribute}!") }.from(identity_value + rand_augment).to(identity_value)
      end

      context 'when reeanbled' do
        let(:reenable_action) { input.send(attribute).enable(augment) }

        before { disable_action }

        it do
          expect do
            reenable_action
          end.to change { input.send(attribute).capacity }.from(identity_value).to(identity_value + rand_augment)
            .and(not_change { input.send("#{attribute}!") })
        end
      end
    end
  end
end
