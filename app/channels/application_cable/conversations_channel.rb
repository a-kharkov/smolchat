# frozen_string_literal: true

module ApplicationCable
  class ConversationsChannel < ApplicationCable::Channel
    private

    def subscribed
      stream_from "users:#{current_user.id}:conversations"
      stream_from "users:#{current_user.id}:conversations:#{@current_conversation.id}"
    end
  end
end
