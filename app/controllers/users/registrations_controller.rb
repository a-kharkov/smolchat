# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

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

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

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
