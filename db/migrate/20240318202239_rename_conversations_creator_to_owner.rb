class RenameConversationsCreatorToOwner < ActiveRecord::Migration[7.1]
  def change
    remove_index :conversations, column: :creator_id
    rename_column :conversations, :creator_id, :owner_id
  end
end
