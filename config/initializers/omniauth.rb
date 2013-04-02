OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, INSTAGRAM_CONFIG['client_id'], INSTAGRAM_CONFIG['client_secret']
end
