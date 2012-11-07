class Denounce < ActiveRecord::Base
  attr_accessible :user_id, :item_id
  validates :user_id, presence: true, uniqueness: {scope: :item_id}

  belongs_to :item
  belongs_to :user
end