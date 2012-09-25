class CreateClassifications < ActiveRecord::Migration
  def up
    change_table :items do |t|
      t.string :category_id
      t.string :category_as
    end
  end

  def down
    remove_column :items, :category_id
    remove_column :items, :category_as
  end
end
