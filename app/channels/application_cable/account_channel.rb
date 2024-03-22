# frozen_string_literal: true

class AccountChannel < ApplicationCable::Channel
  private

  def subscribed
    stream_from "users:#{current_user.id}:account"
  end
end
