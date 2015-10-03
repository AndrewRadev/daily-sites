Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  ENV['TWITTER_KEY'],     ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], {
    client_options: {
      ssl: {
        ca_path: '/usr/lib/ssl/certs',
        ca_file: '/usr/lib/ssl/certs/ca-certificates.crt'
      }
    }
  }
end
