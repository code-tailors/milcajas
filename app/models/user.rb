class User < ActiveRecord::Base
  validate :uid, presence: true

  has_and_belongs_to_many :items

  def self.from_omniauth(auth)
    where(auth.slice("uid")).first || create_from_omniauth(auth)
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
    dbsession = DropboxSession.new(APP_KEY, APP_SECRET)
    dbsession.set_access_token self.token, self.secret
    DropboxClient.new dbsession, :app_folder
  end
end
