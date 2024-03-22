# frozen_string_literal: true

class UsersConversation < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create_commit :notify_create

  private

  def notify_create
    broadcast_prepend_to "users:#{user_id}:conversations",
                         target: 'conversations',
                         partial: 'conversations/conversation',
                         locals: { conversation:, current_user_id: user_id }
  end
end
