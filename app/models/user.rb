class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true

  #has_and_belongs_to_many :items,
    #:after_add => :cuack,
  #  :after_remove => :remove_orphans

  has_many :items

  def reset_items
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
          item = Item.create(path: path, size: entry[1]["size"], mime_type: entry[1]["mime_type"], user_id: id)
        end
      end
    end
    self.update_attribute(:delta_cursor, changes["cursor"])
  end

  def self.from_omniauth(auth)
    where("uid = '?'", auth.uid).first || create_from_omniauth(auth)
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

  # private
  # def remove_orphans(item)
  #   item.destroy if item.users.count == 0
  # end
end
