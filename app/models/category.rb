class Category < ActiveRecord::Base
  CATEGORIES= ["photo","video","movie","comic", "book", "other"]
  attr_accessible :name
  has_many :items, :after_add => :set_category_as


  def set_category_as(item)
    item.update_attribute(:category_as, self.name)
  end

end
