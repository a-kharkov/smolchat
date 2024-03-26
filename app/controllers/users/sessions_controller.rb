# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    private

    def after_sign_out_path_for(...)
      new_user_session_path
    end
  end
end
