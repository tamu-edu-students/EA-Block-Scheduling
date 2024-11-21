source "https://rubygems.org"

ruby "3.3.4"

# Core Rails and Utilities
gem "rails", "~> 7.2.1"                 # Use Rails 7.2.1
gem "puma", ">= 5.0"                    # Web server
gem "sprockets-rails"                   # Asset pipeline
gem "importmap-rails"                   # Use JavaScript with ESM import maps
gem "stimulus-rails"                    # Hotwire's JavaScript framework
gem "turbo-rails"                       # Hotwire's SPA-like page accelerator
gem "jbuilder"                          # Build JSON APIs
gem "simple_form"                       # Easier form handling
gem "bootsnap", require: false          # Reduces boot times through caching; required in config/boot.rb
gem "activestorage", "~> 7.2.1"         # For file uploads and attachments

# Database and Parsing Tools
gem "pg"                                # PostgreSQL database adapter
gem "roo"                               # For parsing Excel files
gem "csv"                               # For handling CSV files
gem "caxlsx"                            # Generate Excel files
gem "caxlsx_rails"                      # Integrate caxlsx with Rails

# Authentication
gem "omniauth"                          # OmniAuth core
gem "omniauth-google-oauth2"            # Google OAuth2 strategy
gem "omniauth-microsoft_graph"          # Microsoft Graph strategy
gem "omniauth-rails_csrf_protection"    # CSRF protection for OmniAuth

# Timezone Information
gem "tzinfo-data", platforms: %i[windows jruby] # Timezone data for Windows and JRuby

# Development and Test Dependencies
group :development, :test do
  gem "sqlite3", "~> 2.2.0"             # Use SQLite for development and test environments
  gem "dotenv-rails"                    # Load environment variables from .env
  gem "brakeman", "6.2.2", require: false # Static analysis for security vulnerabilities
  gem "debug", platforms: %i[mri windows], require: "debug/prelude" # Debugging support
  gem "rubocop-rails-omakase", require: false # Ruby style guide
  gem "factory_bot_rails"               # Fixtures replacement
  gem "rspec-rails"                     # Testing framework
  gem "shoulda-matchers"                # Simplify tests for Rails
  gem "database_cleaner"                # Clean database between tests
  gem "capybara"                        # Acceptance testing
  gem "cucumber-rails", require: false  # BDD framework
  gem "rails-controller-testing"        # Controller test helpers
  gem "selenium-webdriver"              # Web browser automation
  gem "webdrivers"                      # Automatically download webdrivers
  gem "simplecov", require: false       # Code coverage analysis
  gem "ZenTest"                         # Automated test discovery
end

group :development do
  gem "web-console" # Use console on exceptions pages
end
