class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string  :name
      t.string  :path
      t.string  :size
      t.string  :mime_type
      t.string  :description
      t.string  :tags
      t.string  :checksum
      t.timestamps
    end

    add_index :items, :user_id
    add_index :items, :tags
    add_index :items, :checksum
  end
end
