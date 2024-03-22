# frozen_string_literal: true

class AddNameToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :name, :string, null: true
  end
end
