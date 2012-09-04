APP_KEY = "ctneuigl2zz6urw"
APP_SECRET = "cq93sx2x5b7eapc"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, APP_KEY, APP_SECRET
end