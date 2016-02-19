require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "fc62a950681ef1af8e8841c0d87c2349e2a6ef2f1c6eb6202b2d55b0ffa26fc3"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')

  datastore :s3,
    bucket_name: ENV["S3_BUCKET"],
    access_key_id: ENV["S3_ACCESS_KEY"],
    secret_access_key: ENV["S3_SECRET_KEY"]
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
