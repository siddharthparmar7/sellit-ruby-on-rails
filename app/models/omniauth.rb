OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
provider :facebook, ENV['208506126300033'], ENV['281492b0c0b3f08762022ab5106d1035'], {:provider_ignores_state => true}
end
