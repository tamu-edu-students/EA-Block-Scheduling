source "https://rubygems.org"
gem "rails", "~> 7.2.1" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "sprockets-rails" # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sqlite3", ">= 1.4" # Use sqlite3 as the database for Active Record
gem "puma", ">= 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "turbo-rails" # Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails" # Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "tzinfo-data", platforms: %i[ windows jruby ]   # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false    # Reduces boot times through caching; required in config/boot.rb
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-microsoft_graph"
gem "roo"
gem "simple_form"
gem "csv"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", "6.2.2", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec"
  gem "rspec-rails"
  gem "capybara"
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "activestorage", "~> 7.2.1"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  gem "simplecov", require: false
  gem "selenium-webdriver"
  gem "ZenTest"
end
