# frozen_string_literal: true

module ApplicationCable
  class NotificationsChannel < ApplicationCable::Channel
    private

    def subscribed
      stream_from "users:#{current_user.id}:notifications"
    end
  end
end
