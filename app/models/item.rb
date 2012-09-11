require 'digest/md5'

class Item < ActiveRecord::Base
  attr_accessible :name, :description, :path, :size, :mime_type, :user_id
  belongs_to :user

  scope :uniques, select("DISTINCT ON(checksum) name, path, size, mime_type, user_id")

  before_create :set_name, :build_checksum

  def set_name
    self.name = self.path.split("/").last
  end

  def build_checksum
    self.checksum = Digest::MD5.hexdigest(self.name.downcase + self.size)
  end
end
