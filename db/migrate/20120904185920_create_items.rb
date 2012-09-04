class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :name
      t.string  :path
      t.string  :size
      t.string  :mime_type
      t.string  :description
      t.string  :tags
      t.timestamps
    end

    add_index :items, :path
    add_index :items, :tags
    add_index :items, :name
  end
end
