# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider :oath2, ENV['oath2_key'], ENV['oauth2_secret']
end