require 'digest/md5'

class Item < ActiveRecord::Base
#  extend Searchable(:name, :description, :category_as, :tags)
  paginates_per 50

  #include PgSearch
  #pg_search_scope :search, against: [:name, :category_as, :tags]

  attr_accessible :name, :description, :path, :size, :mime_type, :user_id, :category_id, :bytes
  belongs_to :user

  has_many :denounces
  has_many :denouncers, :class_name => "User", :through => :denounces, :source => :user

  belongs_to :category

  scope :uniques, select("DISTINCT ON(checksum) id, name, path, size, mime_type, user_id, category_id").order("checksum, created_at")

  validates :path, :bytes, presence: true

  before_create :set_name, :build_checksum

  def set_name
    self.name = self.path.split("/").last
  end

  def build_checksum
    self.checksum = Digest::MD5.hexdigest(self.name.downcase + self.bytes.to_s)
  end

  def self.text_search(query,page=1,per=20)
    if query.present?
      uniques.where('name ILIKE :search OR description ILIKE :search OR tags ILIKE :search', search: "%#{query}%").page(page).per(per)
    else
      scoped
    end
  end

  def denounce!(user_id)
    Item.where(checksum: self.checksum).each do |item|
      Denounce.create(user_id: user_id, item_id: item.id)
    end
  end

end

# rank = <<-RANK
#   ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)})) +
#   ts_rank(to_tsvector(content), plainto_tsquery(#{sanitize(query)}))
# RANK
# where("name @@ :q or content @@ :q", q: "%#{query}%").order("#{rank} desc")
