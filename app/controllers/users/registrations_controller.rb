# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: :create
    before_action :configure_account_update_params, only: :update

    # PUT /resource
    def update
      self.resource = current_user
      resource_updated = update_resource(current_user, account_update_params)
      yield current_user if block_given?
      if resource_updated
        turbo_toast type: 'notice', msg: find_message(:updated)
        bypass_sign_in current_user, scope: resource_name

        redirect_back fallback_location: root_path
      else
        clean_up_passwords current_user
        set_minimum_password_length
        render :edit, status: :unprocessable_entity
      end
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def set_flash_message(key, kind, options = {})
      if signed_in?
        turbo_toast type: key.to_s, msg: find_message(kind, options)
      else
        super
      end
    end
  end
end
