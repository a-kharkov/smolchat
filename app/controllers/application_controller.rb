# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized

  before_action -> { current_user.touch }, if: :signed_in?
  around_action :use_cookies_timezone

  private

  def turbo_toast(type:, msg:)
    Turbo::StreamsChannel.broadcast_prepend_to "users:#{current_user.id}:notifications",
                                               target: 'toast_container',
                                               partial: 'layouts/toast',
                                               locals: { type:, msg: }
  end

  def handle_unauthorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    message = t exception.query.to_s, scope: "pundit.#{policy_name}", default: :default
    respond_to do |f|
      f.html { flash[:alert] = message }
      f.turbo_stream { turbo_toast(type: 'alert', msg: message) }
    end
    redirect_to root_path
  end

  def use_cookies_timezone(&action)
    Time.use_zone(cookies.fetch(:timezone, nil), &action)
  end
end
