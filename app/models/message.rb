# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  text            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
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
