# frozen_string_literal: true

class CreateUsersConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :users_conversations do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users_conversations, %i[conversation_id user_id], unique: true
  end
end
