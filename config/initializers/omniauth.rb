Rails.application.config.middleware.use OmniAuth::Builder do
  provider :imgur, ENV['imgur_client_id'], ENV['imgur_client_secret']
end

OmniAuth.config.logger = Rails.logger