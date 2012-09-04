class Item < ActiveRecord::Base
  attr_accessible :name, :description, :path, :size, :mime_type, :user_id
  has_and_belongs_to_many :users

end
