class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true

  #has_and_belongs_to_many :items,
    #:after_add => :cuack,
  #  :after_remove => :remove_orphans

  has_many :items, dependent: :destroy
  has_many :denounces
  has_many :denounced_items, :class_name => "Item", :through => :denounces, :source => :item

  def reset_items!
    self.update_attribute(:delta_cursor, nil)
    self.items.destroy_all
    refresh_items
  end

  def refresh_items
    changes = self.dropbox.delta self.delta_cursor
    changes["entries"].each do |entry|
      if entry[1].nil?
        item = self.items.where(path: entry[0]).first
        item.destroy if item
      else
        unless entry[1]["is_dir"]
          path = entry[0]
          item = Item.create(path: path, bytes: entry[1]["bytes"], size: entry[1]["size"], mime_type: entry[1]["mime_type"], user_id: id)
        end
      end
    end
    self.update_attribute(:delta_cursor, changes["cursor"])
  end

  def self.from_omniauth(auth)
    (user = where("uid = '?'", auth.uid).first and user.update_from_omniauth(auth) and user) || create_from_omniauth(auth)
  end

  def update_from_omniauth(auth)
      self.token= auth.credentials.token
      self.secret= auth.credentials.secret
      self.last_sign_in_at = self.current_sign_in_at
      self.current_sign_in_at = Time.now
      self.increment(:sign_in_counter)
      self.save
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.token = auth.credentials.token
      user.secret = auth.credentials.secret
      user.email = auth.info.email
    end
  end

  def dropbox
    dbsession = DropboxSession.new(ENV['APP_KEY'], ENV['APP_SECRET'])
    dbsession.set_access_token self.token, self.secret
    DropboxClient.new dbsession, :app_folder
  end

  def block!
    #block user
  end

  # private
  # def remove_orphans(item)
  #   item.destroy if item.users.count == 0
  # end
end
