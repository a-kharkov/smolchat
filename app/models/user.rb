# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A(\w+ )*\w+\z/, message: 'format is invalid' }

  has_many :owned_conversations, class_name: 'Conversation', inverse_of: :owner
  has_many :users_conversations
  has_many :conversations, through: :users_conversations

  after_update :notify_update

  private

  def notify_update
    broadcast_update_to "users:#{id}:account",
                        target: 'left_offcanvas_header',
                        partial: 'layouts/left_offcanvas/header',
                        locals: { current_user: self }
  end
end
