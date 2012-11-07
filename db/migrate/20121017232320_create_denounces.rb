class CreateDenounces < ActiveRecord::Migration
  def up
     create_table :denounces do |t|
      t.integer :user_id
      t.integer :item_id
    end
    add_index :denounces, [:user_id, :item_id], unique: true

  end

  def down
    drop_table :denounces
  end
end
