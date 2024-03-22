# frozen_string_literal: true

module ApplicationCable
  class AccountChannel < ApplicationCable::Channel
    private

    def subscribed
      stream_from "users:#{current_user.id}:account"
    end
  end
end
