ACCESS_TYPE = :app_folder

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, ENV['APP_KEY'], ENV['APP_SECRET']
end