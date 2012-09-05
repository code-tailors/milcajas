class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid
      t.string :name
      t.string :email
      t.string :token
      t.string :secret
      t.string :country
      t.string :checksum
      t.string :delta_cursor
      t.timestamps
    end

    add_index :users, :uid
  end
end
