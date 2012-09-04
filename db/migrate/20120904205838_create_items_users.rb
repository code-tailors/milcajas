class CreateItemsUsers < ActiveRecord::Migration
  def up
    create_table :items_users, id: false do |t|
      t.integer :user_id
      t.integer :item_id
    end

    add_index :items_users, [:user_id, :item_id], unique: true
  end

  def down
  end
end
