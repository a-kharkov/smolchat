# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user, name:, email:) }

  let(:name) { 'DefinitelyValidName' }
  let(:email) { 'definitely@valid.email' }

  describe 'Validations' do
    it { is_expected.to be_valid }

    describe '#name' do
      context 'when name format is bad' do
        let(:name) { '@!%^&*#$' }

        it { is_expected.not_to be_valid }
      end

      context 'when name is blank' do
        let(:name) { '' }

        it { is_expected.not_to be_valid }
      end
    end

    describe '#email' do
      context 'when email format is bad' do
        let(:email) { '!%^&*#$' }

        it { is_expected.not_to be_valid }
      end

      context 'when email is blank' do
        let(:email) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when email already exists' do
        before { create(:user, email: user.email) }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe 'Callbacks' do
    describe '.after_update_commit' do
      context 'with new user' do
        let(:user) { build(:user) }

        before do
          allow(user).to receive(:broadcast_update_to)
          user.save
        end

        it 'does not notify stream' do
          expect(user).not_to have_received(:broadcast_update_to)
        end
      end

      context 'with persisted user' do
        let(:user) { create(:user) }

        let(:broadcast_args) do
          [
            "users:#{user.id}:account",
            {
              target: 'left_offcanvas_header',
              partial: 'layouts/left_offcanvas/header',
              locals: { current_user: user }
            }
          ]
        end

        before do
          allow(user).to receive(:broadcast_update_to)
          user.touch
        end

        it 'notifies stream' do
          expect(user).to have_received(:broadcast_update_to).with(*broadcast_args).once
        end
      end
    end
  end
end
