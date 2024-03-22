# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  group      :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Conversation < ApplicationRecord
  belongs_to :owner, class_name: 'User', inverse_of: :owned_conversations
  has_many :users_conversations, dependent: :destroy
  has_many :users, through: :users_conversations
  has_many :messages, -> { order(created_at: :asc) }, inverse_of: :conversation, dependent: :destroy

  validates :name, presence: true, if: :group?
  validates :users, length: { minimum: 1, too_short: :blank }, if: :group?
  validates :users, length: { is: 2, wrong_length: :blank }, unless: :group?

  after_update_commit :notify_update

  private

  def notify_update
    users.each do |u|
      broadcast_remove_to "users:#{u.id}:conversations",
                          target: "conversation_#{id}"
      broadcast_prepend_to "users:#{u.id}:conversations",
                           locals: { current_user_id: u.id }
      broadcast_replace_to "users:#{u.id}:conversations:#{id}",
                           target: 'conversation_info',
                           partial: 'conversations/conversation_info',
                           locals: { user: u }
    end
  end
end
