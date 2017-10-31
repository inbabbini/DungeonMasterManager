Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_ID, Rails.application.secrets.google_client_secret
end
