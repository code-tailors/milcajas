class AddCategories < ActiveRecord::Migration
  def up
    Category.create(name: "video")
    Category.create(name: "musica")
    Category.create(name: "libro")
    Category.create(name: "foto")
    Category.create(name: "comic")
    Category.create(name: "otro")
  end

  def down
    Category.destroy_all
  end
end
