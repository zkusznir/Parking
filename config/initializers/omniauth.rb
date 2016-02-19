Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_API_KEY"], ENV["FB_SECRET_KEY"]
end
