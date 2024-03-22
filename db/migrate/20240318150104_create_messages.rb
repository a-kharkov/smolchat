# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :text
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
