class AddCategories < ActiveRecord::Migration
  def up
    Category::CATEGORIES.each do |name|
      Category.create(name: name)
    end
  end

  def down
    Category.destroy_all
  end
end
