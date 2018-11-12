Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["APP_KEY"], ENV["APP_SECRET_KEY"]
end