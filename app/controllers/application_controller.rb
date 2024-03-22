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
    message = t(exception.query.to_s, scope: "pundit.#{policy_name}", default: :default)
    respond_to do |f|
      f.html do
        flash[:alert] = message
        redirect_to root_path
      end
      f.turbo_stream do
        turbo_toast(type: 'alert', msg: message)
        redirect_to root_path
      end
    end
  end

  def use_cookies_timezone(&)
    Time.use_zone(cookies.fetch(:timezone, nil), &)
  end
end
