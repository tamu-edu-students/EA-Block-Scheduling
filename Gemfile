source "https://rubygems.org"

gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "csv"
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-microsoft_graph"
gem "puma", ">= 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.2.1" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "roo"  # For parsing Excel files
gem "simple_form"  # For easier form handling
gem "sprockets-rails" # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sqlite3", "~> 1.6.6"  # Use sqlite3 as the database for Active Record
gem "stimulus-rails" # Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "turbo-rails" # Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "tzinfo-data", platforms: %i[ windows jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  gem "simplecov", require: false
  gem "selenium-webdriver"
  gem "ZenTest"
end

group :development, :test do
  gem "activestorage", "~> 7.2.1"
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "6.2.2", require: false
  gem "capybara"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rails-controller-testing"
  # Setting Rspec to dev
  gem "rspec"
  gem "rspec-rails"
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "webdrivers"
  gem "factory_bot_rails"
end
