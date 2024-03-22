# frozen_string_literal: true

class NotificationsChannel < ApplicationCable::Channel
  private

  def subscribed
    stream_from "users:#{current_user.id}:notifications"
  end
end
