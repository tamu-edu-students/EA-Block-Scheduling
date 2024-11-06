module AuthenticationHelper
  def log_in_user(user = nil)
    user ||= FactoryBot.create(:user) # Create or use a default user for login
    post login_path, params: { session: { email: user.email, password: user.password } }
  end

  def login_as_admin_user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '12345',
      info: { email: 'adminuser@example.com', name: 'Admin User' }
    })

    visit '/auth/google_oauth2/callback'  # Simulates OmniAuth callback
  end

  def login_as_student_user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '67890',
      info: { email: 'studentuser@example.com', name: 'Student User' },
      role: 'student'
    })

    # Simulate OmniAuth callback
    visit '/auth/google_oauth2/callback'
  end

  def reset_sessions!
    Capybara.reset_sessions!
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request # For request specs
  config.include AuthenticationHelper, type: :feature # For feature specs
end
