# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create :notify_create, :touch_conversation

  private

  def notify_create
    conversation.users.ids.each do |notify_user_id|
      broadcast_append_to "users:#{notify_user_id}:conversations:#{conversation_id}",
                          target: :messages_container,
                          locals: { current_user_id: notify_user_id, conversation: }
    end
  end

  def touch_conversation
    conversation.touch
  end
end
