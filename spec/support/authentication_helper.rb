module AuthenticationHelper
  def log_in_user(user = nil)
    user ||= FactoryBot.create(:user) # Create or use a default user for login
    post login_path, params: { session: { email: user.email, password: user.password } }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request # For request specs
  config.include AuthenticationHelper, type: :feature # For feature specs
end
