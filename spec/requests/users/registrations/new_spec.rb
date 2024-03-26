# frozen_string_literal: true

require 'rails_helper'

describe 'GET /users/sign_up' do
  context 'when not logged in' do
    it 'visit registration page' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  context 'when logged in' do
    let(:user) { create(:user) }

    before { sign_in user }

    it 'visit registration page' do
      get new_user_registration_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end
end
