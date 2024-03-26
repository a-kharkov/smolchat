# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users' do
  let(:user) { build(:user) }
  let(:name) { user.name }
  let(:user_params) do
    {
      user: {
        name:,
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }
    }
  end

  context 'when not logged in' do
    context 'with valid params' do
      it 'submit registration form' do
        expect { post user_registration_path, params: user_params }.to change(User, :count).by(1)
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when email already exists' do
      before { create(:user, email: user.email) }

      it 'submit registration form' do
        expect { post user_registration_path, params: user_params }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid name' do
      let(:name) { 'd3f!n!73ly !nv@1!d n@m3' }

      it 'submit registration form' do
        expect { post user_registration_path, params: user_params }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'when logged in' do
    before { sign_in user.tap(&:save) }

    it 'submit registration form' do
      expect { post user_registration_path, params: user_params }.not_to change(User, :count)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end
end
