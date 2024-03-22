class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.boolean :group
      t.references :creator, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
