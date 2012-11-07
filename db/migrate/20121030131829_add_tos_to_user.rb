class AddTosToUser < ActiveRecord::Migration
  def up
    add_column :users, :tos, :boolean, default: false
  end

  def down
    remove_column :users, :tos
  end
end
