# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.boolean :group, null: false, default: false
      t.references :creator, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
