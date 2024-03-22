# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A(\w+ )*\w+\z/, message: :invalid_format }

  has_many :owned_conversations, class_name: 'Conversation', inverse_of: :owner, dependent: :destroy
  has_many :users_conversations, dependent: :destroy
  has_many :conversations, through: :users_conversations

  after_update_commit :notify_update

  private

  def notify_update
    broadcast_update_to "users:#{id}:account",
                        target: 'left_offcanvas_header',
                        partial: 'layouts/left_offcanvas/header',
                        locals: { current_user: self }
  end
end
